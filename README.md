# Logexch

**Collector for NGINX logs to Clickhouse written by Elixir**

## Configure

1. Put your database settings to `config/config.exs`
2. Put your secrets to `envs/.env` (see `envs/example.env`)
3. See `nginx.conf` for update your nginx config and `clickhouse_schema.sql` for Clickhouse migration. You need synchronize schema for `nginx.conf` and `clickhouse_schema.sql`.
If you need modify access log schema, use `mix generate_configs` (`lib/mix/tasks/generate_configs.ex`).


## Bare metal deployment
This is a typical Elixir application that use `mix`: 

1. Clone this repo;
2. Run `mix deps.get`;
3. Run `mix compile` or `iex -S mix` for devel. process;
4. For build prod version run `mix release`.

For production use `./scripts`:

1. Clone this repo;
2. `cd logexch`
3. `./scripts/build.sh`
4. `mix generate_configs` for generate systemd unit and nginx/clickhouse compatible schema
5. `./scripts/install.sh`

After this you can run and stop `logexch` system serivice:

```
systemctl start logexch.service
systemctl status logexch.service
systemctl stop logexch.service
```

## How it's work

1. You describe the data schema you want to store in Clickhouse or use the default one.
2. You generate configurations and build this application.
3. Modify your nginx.conf. Migrate by Clickhouse schema.
4. Run system service `logexch`. The application listens to a UDP port, where NGINX will send logs in JSON format.
5. Logs are parsed, collected in a queue, and written to your Clichhouse locally or remotely.
6. The throughput is amazing.
