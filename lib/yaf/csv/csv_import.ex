defmodule Yaf.CSV.Import do
  alias Yaf.CSV
  alias Yaf.Repo

  defmodule Row do
    @moduledoc false
    defstruct [
      :english,
      :translated,
      :language
    ]
  end

  def import_csv(file) when is_binary(file) do
    file
    |> CSV.parse()
    |> combine()
    |> process()
  end

  def combine({header_cols, rows}) do
    rows
    |> Enum.map(fn row ->
      struct_input =
        header_cols
        |> Enum.map(&String.to_atom/1)
        |> Enum.zip(row)
        |> Enum.into(%{})

      struct(Row, struct_input)
    end)
  end

  def process(rows), do: import_rows(rows)

  def import_rows([_ | _] = rows) do
     Repo.transaction(
      fn ->
        imported =
          for row <- rows do
          import_row(row)
      end

      imported
      end,
      timeout: 120_000
     )
  end

  def import_row(row) do
    %{english: row.english, translated: row.translated, language: row.language}
  end
end
