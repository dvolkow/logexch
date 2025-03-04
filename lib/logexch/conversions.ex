defmodule Logexch.Conversions do
  require Logger

  def to_int("") do
    0
  end

  def to_int(value) when is_binary(value) do
    value
    |> String.to_integer()
  end

  def to_int(value) when is_number(value) do
    value
  end

  def to_float("") do
    0.0
  end

  def to_float(value) when is_binary(value) do
    {res, _} = Float.parse(value)
    res
  end

  def to_float(value) when is_number(value) do
    to_float("#{value}")
  end

  def to_ipv4(value) when is_binary(value) do
    {status, res} =
      value
      |> String.to_charlist()
      |> :inet.parse_ipv4_address()

    case status do
      :ok ->
        res

      _ ->
        # Logger.warning("failed to_ipv4: #{status}, #{res}. Return default")
        {:ok, res} = :inet.parse_ipv4_address(~c"127.0.0.1")
        res
    end
  end

  def conv(value, type) do
    case type do
      "String" -> to_string(value)
      "UInt16" -> to_int(value)
      "UInt32" -> to_int(value)
      "Float32" -> to_float(value)
      "Float64" -> to_float(value)
      "IPv4" -> to_ipv4(value)
      _ -> value
    end
  end
end
