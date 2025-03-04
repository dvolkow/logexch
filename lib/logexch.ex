defmodule Logexch do
  use GenServer
  require Logger

  @default_timeout_sec 60

  def start_link(init_state) do
    GenServer.start_link(__MODULE__, init_state, name: __MODULE__)
  end

  def init(
        database: db_name,
        table: db_table,
        port: db_port,
        host: host,
        user: user,
        password: password,
        pool_size: pool_size,
        rate: rate,
        batch_size: batch_size
      ) do
    # you can add more clickhouses here
    local_defaults = [
      scheme: "http",
      hostname: host,
      port: db_port,
      database: db_name,
      settings: [
        user: user,
        password: password
      ],
      pool_size: pool_size,
      timeout: :timer.seconds(@default_timeout_sec)
    ]

    {:ok, local_pid} = Ch.start_link(local_defaults)

    schedule_insert(rate)

    {:ok,
     %{conn: local_pid, table: db_table, rate: rate, batch_size: batch_size, queue: [], qlen: 0}}
  end

  def enqueue(row) when is_list(row) do
    GenServer.cast(__MODULE__, {:enqueue, row})
  end

  def queue() do
    GenServer.call(__MODULE__, :queue)
  end

  def handle_call(:queue, _from, %{queue: queue} = state) do
    {:reply, queue, state}
  end

  def handle_cast({:enqueue, row}, %{queue: queue, qlen: qlen} = state) when is_list(row) do
    {:noreply, %{state | qlen: qlen + 1, queue: [row | queue]}}
  end

  def handle_info(:insert, %{rate: rate} = state) do
    new_state =
      case check_and_insert(state) do
        :ok -> %{state | queue: [], qlen: 0}
        _ -> state
      end

    schedule_insert(rate)
    {:noreply, new_state}
  end

  def handle_info(_, state) do
    {:noreply, state}
  end

  defp schedule_insert(rate) when is_number(rate) do
    Process.send_after(self(), :insert, rate)
  end

  defp check_and_insert(state) do
    if state.qlen >= state.batch_size do
      Task.start(fn -> ch_insert(state) end)
      :ok
    end
  end

  defp ch_insert(%{conn: conn, table: table, queue: queue, qlen: qlen}) when is_list(queue) do
    sql_query = "INSERT INTO #{table} FORMAT RowBinaryWithNamesAndTypes"
    opts = Logexch.Scheme.opts()

    conn
    |> Ch.query!(sql_query, queue, opts)

    Logger.debug("insert to #{table} #{qlen} rows.")
  end
end
