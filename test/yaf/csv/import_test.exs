defmodule Yaf.CSV.ImportTest do
  use Yaf.DataCase, async: true

  alias Yaf.CSV.Import
  alias Yaf.CSV.Import.Row

  @csv_header """
  english,translated,language
  """

  def sample_data do
    %Row{
      english: "to eat",
      translated: "먹다",
      language: "korean"
    }
  end

  def sample_row(overrides \\ []) do
    row =
      sample_data()
      |> struct(overrides)

    Enum.join(
      [
        row.english,
        row.translated,
        row.language
      ],
      ","
    ) <> "\n"
  end

  def wrap_csv(rows = [_ | _]), do: IO.chardata_to_string([@csv_header | rows])

  test "basic successful import" do
    assert {:ok, [%{english: "to eat", translated: "먹다", language: "korean"}]} =
             [
               sample_row()
             ]
             |> wrap_csv()
             |> Import.import_csv()

    # TODO add db test
  end
end
