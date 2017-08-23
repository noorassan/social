defmodule Social.Repo.Migrations.AddProfilePicturePathToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :profile_picture_path, :string, null: false
    end
  end
end
