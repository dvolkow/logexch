defmodule Logexch.Scheme do
  @tag Application.compile_env(:logexch, :tag)
  @defaults %{
    "String" => "",
    "UInt16" => 0,
    "UInt32" => 0,
    "IPv4" => "0.0.0.0",
    "LowCardinality(String)" => "",
    "Float32" => 0.0,
    "Float64" => 0.0
  }
  @scheme [
    "args String",
    "body_bytes_sent UInt32",
    "bytes_sent UInt32",
    "connection UInt32",
    "connection_requests UInt32",
    "host LowCardinality(String)",
    "hostname LowCardinality(String)",
    "http_referer LowCardinality(String)",
    "http_user_agent String",
    "is_args LowCardinality(String)",
    "msec Float64",
    "remote_addr IPv4",
    "remote_port UInt16",
    "remote_user LowCardinality(String)",
    "request String",
    "request_completion LowCardinality(String)",
    "request_id String",
    "request_length UInt32",
    "request_method LowCardinality(String)",
    "request_time Float32",
    "response_code UInt16",
    "server_protocol LowCardinality(String)",
    "url String"
  ]

  def parse(data) do
    js =
      data
      |> String.split(@tag)
      |> tl
      |> Jason.decode!()

    @scheme
    |> Enum.map(fn row ->
      [name, type] = String.split(row)

      Map.get(js, name, @defaults[type])
      |> Logexch.Conversions.conv(type)
    end)
  end

  def opts() do
    opts =
      @scheme
      |> Enum.reverse()
      |> Enum.reduce(
        [names: [], types: []],
        fn row, [names: names, types: types] ->
          [name, type] = row |> String.split()
          [names: [name | names], types: [type | types]]
        end
      )

    opts
  end
end
