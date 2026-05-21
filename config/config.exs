import Config

config :logexch,
  # port for UDP server that collect nginx log entries:
  port: 4355,
  # separator, see nginx.conf:
  tag: "nginx_access:",
  insert_timeout: 60_000
