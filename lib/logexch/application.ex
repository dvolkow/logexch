defmodule Logexch.Application do
  use Application
  require Logger

  @default_timeout 60_000

  def start(_type, _args) do
    tables = [
      {:server, :access_log,
       Application.fetch_env!(:logexch, :insert_timeout) || @default_timeout,
       ["insert_time", "timestamp", "log_line_num"]}
    ]

    children = [
      {EasyClickhouse.Supervisor, tables: tables},
      Logexch
    ]

    opts = [strategy: :one_for_one, name: Logexch.Supervisor]
    Logger.info("logexch is starting...")
    Supervisor.start_link(children, opts)
  end
end
