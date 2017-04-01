defmodule Social.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :message, :text, null: false
      add :creator, :text, null: false

      timestamps()
    end
  end
end
