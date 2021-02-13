defmodule Tty6EQUJ5.IO do
  use GenEvent
  use GenServer
  alias Tty6EQUJ5.Game
  alias IO.ANSI
  
  def start_link(from) do
    GenServer.start_link(__MODULE__, from, [name: __MODULE__])
  end


  def move(side) do
    GenServer.cast(__MODULE__, {:move, side})
  end

  def handle_cast({:move, side}, {manager, %__MODULE__{} = game}) do
    case move(game, side) do
      {true, game} ->
        GenEvent.notify(manager, {:moved, game})
        {:noreply, {manager, game}}
      {false, game} ->
        GenEvent.notify(manager, {:game_over, game})
        {:noreply, {manager, game}}
    end
  end

  defp new(%__MODULE__{} = game), do: game

  defp new(size) when is_integer(size) do
    %__MODULE__{grid: Grid.new(size)}
  end

  defp move(%{grid: grid, score: score}, side) do
    {grid, points} = Grid.move(grid, side)
    game = %__MODULE__{grid: grid, score: score + points}
    {Grid.has_move?(grid), game}
  end
  
  def init({%Game{} = game, _args}) do
    print_game(game)
    {:ok, Port.open({:spawn, "tty_sl -c -e"}, [:binary, :eof])}
  end

  def handle_event({:moved, %Game{} = game}, state) do
    print_game(game)
    {:ok, state}
  end

  def handle_info({pid, {:data, data}}, pid) do
    if side = translate(data), do: Game.move(side)
    {:ok, pid}
  end

  defp translate("\e[A"), do: :up
  defp translate("\e[B"), do: :down
  defp translate("\e[C"), do: :right
  defp translate("\e[D"), do: :left
  defp translate(_other), do: nil

  def format(%Tty6EQUJ5.Game{} = game) do
    [ANSI.home, ANSI.clear,
     format_score(game),
     format_grid(game),
     ANSI.reset]
  end

  defp print_game(game) do
    format(game)
    |> IO.write
  end
end
