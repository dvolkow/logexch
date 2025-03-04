# Logexch

**Collector for NGINX logs to Clickhouse written by Elixir**

## Configure

1. Put your database settings to `config/config.exs`
2. Put your secrets to `envs/.env` (see `envs/example.env`)
3. See `nginx.conf` for setup nginx schema. If you need modify access log scheme, don't forget about `logexch/scheme.ex` 
4. `tables.sql`: Clickhouse table examples
You need synchronize schema for all this items, or just use my `nginx.conf` for access log setup.


## Installation
This is a typical Elixir application that use `mix`: 

1. Clone this repo;
2. Run `mix deps.get`;
3. Run `mix compile` or `iex -S mix` for devel. process;
4. For build prod version run `mix release`.

