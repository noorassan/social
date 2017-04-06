defmodule Social.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :user_one_id, references(:users)
      add :user_two_id, references(:users)

      timestamps()
    end
  end
end
