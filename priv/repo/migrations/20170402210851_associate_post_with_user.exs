defmodule Social.Repo.Migrations.AssociatePostWithUser do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :creator
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
