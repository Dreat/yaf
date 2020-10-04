NimbleCSV.define(Yaf.CSV.Comma, separator: ",", escape: "\"")

defmodule Yaf.CSV do
  alias Yaf.CSV.Comma

  def parse(file) do
    [header_cols | rows] =
      file
      |> Comma.parse_string(skip_headers: false)
      |> Enum.map(fn row ->
        Enum.map(row, fn col -> String.trim(col) end)
      end)

    {header_cols, rows}
  end
end
