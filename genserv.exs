defmodule Tcprpc.Server do
  use GenServer

  defmodule State do
     defstruct port: nil, lsock: nil, request_count: 0
  end

  def start_link(port) do
    :gen_server.start_link({ :local, :tcprcp }, __MODULE__, port, [])
  end

  def start_link() do
    start_link 1055
  end

  def get_count() do
    :gen_server.call(:tcprcp, :get_count)
  end

  def stop() do
    :gen_server.cast(:tcprcp, :stop)
  end

  def init (port) do
    { :ok, lsock } = :gen_tcp.listen(port, [{ :active, true }])
    { :ok, %State{lsock: lsock, port: port}, 0 }
  end

  def handle_call(:get_count, _from, state) do 
    { :reply, { :ok, state.request_count }, state }
  end

  def handle_cast(:stop , state) do
    { :noreply, state }
  end

  def handle_info({ :tcp, socket, raw_data}, state) do
    do_rpc socket, raw_data
    { :noreply, %{ state | request_count: state.request_count + 1 } }
  end

  def handle_info(:timeout, state) do
    { :ok, _sock } = :gen_tcp.accept state.lsock
    { :noreply, state }
  end

  def do_rpc(socket, raw_data) do
    try do
      result = Code.eval_string(raw_data)
      :gen_tcp.send(socket, :io_lib.fwrite("~p~n", [result]))
    catch
      error -> :gen_tcp.send(socket, :io_lib.fwrite("~p~n", [error]))
    end
  end

end
