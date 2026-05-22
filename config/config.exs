import Config

config :logexch,
  # port for UDP server that collect nginx log entries:
  port: 4355,
  # separator, see nginx.conf:
  tag: "nginx_access",
  log_table: :access_log,
  log_database: :server,
  insert_timeout: 60_000
