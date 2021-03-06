defmodule Yaf.Flashcards.Flashcard do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:english, :translated, :language]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "flashcards" do
    field :english, :string
    field :translated, :string
    field :language, :string

    timestamps()
  end

  def changeset(flashcard, attrs) do
    flashcard
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
