defmodule Logexch.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {
        Logexch,
        database: Application.fetch_env!(:logexch, :database),
        table: Application.fetch_env!(:logexch, :table),
        port: Application.fetch_env!(:logexch, :ch_port),
        host: Application.fetch_env!(:logexch, :ch_host),
        user: Application.fetch_env!(:logexch, :ch_user),
        password: Application.fetch_env!(:logexch, :ch_password),
        pool_size: Application.fetch_env!(:logexch, :pool_size),
        rate: Application.fetch_env!(:logexch, :rate),
        batch_size: Application.fetch_env!(:logexch, :batch_size)
      },
      {
        Logexch.UDPServer,
        port: Application.fetch_env!(:logexch, :port)
      }
    ]

    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Logger.debug("logexch is starting...")
    Supervisor.start_link(children, opts)
  end
end
