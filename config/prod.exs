import Config

config :logger,
  backends: [:console, {LoggerFileBackend, :info_log}, {LoggerFileBackend, :error_log}],
  compile_time_purge_matching: [
    [level_lower_than: :info]
  ]

config :logger, :info_log,
  path: "/var/log/logexch/info.log",
  level: :info,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:module, :function, :line]

config :logger, :error_log,
  path: "/var/log/logexch/error.log",
  level: :error,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:module, :function, :line]
