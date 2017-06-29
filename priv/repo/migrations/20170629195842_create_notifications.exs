defmodule Social.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :message, :string
      
      timestamps()
    end
  end
end
