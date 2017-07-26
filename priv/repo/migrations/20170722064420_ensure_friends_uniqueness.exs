defmodule Social.Repo.Migrations.EnsureFriendsUniqueness do
  use Ecto.Migration

  def change do
    create unique_index(:friends, [:user_id, :friend_id], name: :friends_uniqueness)
  end
end
