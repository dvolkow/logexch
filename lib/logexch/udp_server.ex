defmodule Logexch.UDPServer do
  use GenServer
  require Logger

  @recbufsz 65000

  def start_link(init_state) do
    GenServer.start_link(__MODULE__, init_state, name: __MODULE__)
  end

  def init([port: port] = state) when is_number(port) do
    {:ok, _pid} = Task.start_link(fn -> listen(port) end)
    {:ok, state}
  end

  defp listen(port) when is_number(port) do
    {:ok, socket} =
      :gen_udp.open(port, [:binary, active: true, recbuf: @recbufsz, ip: {127, 0, 0, 1}])

    Logger.debug("UDP-server for accept access log has been started on #{port} port")

    loop_receive(socket)
  end

  defp loop_receive(socket) do
    receive do
      {:udp, _pid, _ip, _port, data} ->
        Task.start(fn -> handle_message(data) end)

        loop_receive(socket)

      any ->
        Logger.debug("unknown data has been accepted: #{inspect(any)}.")
        loop_receive(socket)
    after
      100 ->
        loop_receive(socket)
    end
  end

  defp handle_message(data) do
    data
    |> Logexch.Scheme.parse()
    |> Logexch.enqueue()
  end
end
