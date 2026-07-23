defmodule Mix.Tasks.GenerateConfigs do
  use Mix.Task

  def run(_args) do
    build_systemd_unit()
    build_nginx_conf()
    build_clickhouse_schema()
  end

  defp build_systemd_unit() do
    [
      user: "logexch",
      group: "logexch",
      install_dir: "/srv/logexch"
    ]
    |> render("logexch.service")
  end

  defp build_nginx_conf() do
    [
      address: Application.fetch_env!(:logexch, :address),
      port: Application.fetch_env!(:logexch, :port),
      separator: Application.fetch_env!(:logexch, :tag)
    ]
    |> render("nginx.conf")
  end

  defp build_clickhouse_schema() do
    [
      database: Application.fetch_env!(:logexch, :log_database),
      table: Application.fetch_env!(:logexch, :log_table)
    ]
    |> render("clickhouse_schema.sql")
  end

  defp render(assigns, file_name) do
    template_path = Path.expand("priv/templates/#{file_name}.eex")
    rendered = EEx.eval_file(template_path, assigns: assigns)

    File.write!(file_name, rendered)
    IO.puts("✅ Generated #{file_name}")
  end
end
