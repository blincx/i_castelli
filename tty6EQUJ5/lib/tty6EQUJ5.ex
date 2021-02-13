defmodule Tty6EQUJ5 do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children =
      [worker(Tty6EQUJ5.Game, [4])]

    Supervisor.start_link(children, strategy: :rest_for_one)
  end
end
