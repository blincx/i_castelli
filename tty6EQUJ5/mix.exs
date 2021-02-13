defmodule Tty6EQUJ5.Mixfile do
  use Mix.Project

  def project do
    [app: :tty6EQUJ5,
     version: "0.0.1",
     elixir: "~> 1.0",
     escript: escript()]
  end

  def application do
    [applications: [],
     mod: {Tty6EQUJ5, []}]
  end

  defp escript do
    [main_module: Tty6EQUJ5.CLI,
     emu_args: "-noinput -elixir ansi_enabled true"]
  end
end
