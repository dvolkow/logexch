CREATE TABLE server.access_log
(
  `insert_time` DateTime DEFAULT now(),
  `args` String,
  `body_bytes_sent` UInt32,
  `bytes_sent` UInt32,
  `connection` UInt32,
  `connection_requests` UInt32,
  `host` LowCardinality(String),
  `hostname` LowCardinality(String),
  `http_referer` LowCardinality(String),
  `http_user_agent` String,
  `is_args` LowCardinality(String),
  `msec` Float64,
  `timestamp` DateTime DEFAULT toDateTime(msec),
  `remote_addr` IPv4,
  `remote_addr_v6` IPv6,
  `remote_port` UInt16,
  `remote_user` LowCardinality(String),
  `request` String,
  `request_completion` LowCardinality(String),
  `request_id` String,
  `request_length` UInt32,
  `request_method` LowCardinality(String),
  `request_time` Float32,
  `response_code` UInt16,
  `server_protocol` LowCardinality(String),
  `url` String
)
ENGINE = ReplacingMergeTree
PRIMARY KEY (insert_time, timestamp, request_id)
ORDER BY (insert_time, timestamp, request_id)
SETTINGS index_granularity = 8192
