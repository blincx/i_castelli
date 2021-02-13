defmodule BatchQueue do
  use GenServer

  def init(queue) do
    {:ok, queue}
  end


  def start_link() do
    IO.puts "start link called"
    GenServer.start_link(__MODULE__, :queue.new())
  end

  def add(pid, item) do  
    IO.puts "added"
    IO.inspect item
    GenServer.cast(pid, {:add, item})
  end

  def handle_cast({:add, item},queue) do
    IO.puts "handling the add call baby!"
    {:noreply, :queue.in(item,queue)}
  end

  def list(pid) do 
    IO.puts "list called"
    GenServer.call(pid, :list)
  end

  def handle_call(:list,pid,queue) do
    IO.puts "handling this list call!"
    {:reply, :queue.to_list(queue),queue}
  end

  def length(pid) do  
    IO.puts "length called"
    GenServer.call(pid, :length)
  end

  def handle_call(:length, _from, queue) do
    IO.puts "Handling this length call babe!"
    {:reply, :queue.len(queue), queue}
  end

  def fetch(pid) do  
    IO.puts "fetch called"
    GenServer.call(pid, :fetch)
  end

  def handle_call(:fetch,_from, queue) do
    IO.puts "handling this fetch call!"
    with {{:value,item},new_queue} <- :queue.out(queue) do
      IO.puts "adding to queue"
      {:reply, item, new_queue}
    else
      {:empty, _} ->
        IO.puts "empty empty something something"
        {:reply, :empty, queue}
    end
  end



end
