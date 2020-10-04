defmodule Yaf.CSV.Import do
  alias Yaf.CSV
  alias Yaf.Flashcards
  alias Yaf.Flashcards.Flashcard
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
    case Repo.get_by(Flashcard, english: row.english, language: row.language) do
      nil -> create_flashcard(row)
      _ -> {:skip, :already_imported}
    end
  end

  defp create_flashcard(row) do
    {:ok, flashcard} = Flashcards.create_flashcard(row.english, row.translated, row.language)
    flashcard
  end
end
