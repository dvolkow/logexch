defmodule Logexch.Parser do
  require Logger
  @tag "#{Application.compile_env(:logexch, :tag)}:"

  @spec parse(String.t(), atom(), atom()) :: [EasyClickhouse.RowParser.t()]
  def parse(data, database, table) when is_binary(data) do
    with [_ | tl] <- data |> String.split(@tag),
         {:ok, decoded_data} <- Jason.decode(tl),
         [names: names, types: types] <- EasyClickhouse.table_opts(database, table) do
      Enum.zip(names, types)
      |> Enum.map(fn {field_name, field_type} ->
        EasyClickhouse.RowParser.parse(decoded_data, field_name, field_type)
      end)
    else
      e ->
        Logger.error("parse error: #{inspect(e)}")
        []
    end
  end
end
