defmodule Tty6EQUJ5.CLI do
  def main(_args) do
    Tty6EQUJ5.Game.Watcher.start_link(Tty6EQUJS.IO)

    :erlang.hibernate(Kernel, :exit, [:killed])
  end
end

