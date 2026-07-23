import Config

config :logger,
  backends: [
    :console,
    {LoggerFileBackend, :info},
    {LoggerFileBackend, :error},
    {LoggerFileBackend, :debug}
  ]

config :logger, :info_log,
  path: "./info.log",
  level: :info,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:module, :function, :line]

config :logger, :error_log,
  path: "./error.log",
  level: :error,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:module, :function, :line]

config :logger, :debug_log,
  path: "./debug.log",
  level: :debug,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:module, :function, :line]
