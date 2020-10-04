defmodule Yaf.Flashcards do
  alias Yaf.Flashcards.Flashcard
  alias Yaf.Repo

  def create_flashcard(english, translated, language) do
    attrs = %{
      english: english,
      translated: translated,
      language: language
    }

    %Flashcard{}
    |> Flashcard.changeset(attrs)
    |> Repo.insert()
  end
end
