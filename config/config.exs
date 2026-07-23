import Config

config :logexch,
  # address of UDP server that collect nginx log entries:
  address: "127.0.0.1",
  # port for UDP server that collect nginx log entries:
  port: 4355,
  # separator for nginx.conf:
  tag: "nginx_access",
  # dst clickhouse table:
  log_table: :access_log,
  log_database: :server,
  insert_timeout: 60_000

import_config "#{config_env()}.exs"
