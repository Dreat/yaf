defmodule Yaf.Repo.Migrations.AddFlashcardsTable do
  use Ecto.Migration

  def change do
    create table(:flashcards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :english, :string
      add :translated, :string
      add :language, :string

      timestamps()
    end
  end
end
