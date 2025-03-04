import Config

config :logexch,
  # port for UDP server that collect nginx log entries:
  port: 4355,
  # separator, see nginx.conf:
  tag: "nginx_access:",
  # typical Clickhouse database settings:
  database: "server",
  table: "server.access_log",
  ch_host: "localhost",
  ch_port: 8123,
  # may be you need more, depends of load:
  pool_size: 1,
  # rate is time in milliseconds, 1_000 is 1 second:
  rate: 3_000,
  # min. collector queue length for insert to Clickhouse:
  batch_size: 10

# import_config "#{config_env()}.exs"
