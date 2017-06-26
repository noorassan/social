defmodule Social.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :user_one_id, references(:users, on_delete: :delete_all)
      add :user_two_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
