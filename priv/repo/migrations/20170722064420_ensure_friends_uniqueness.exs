defmodule Social.Repo.Migrations.EnsureFriendsUniqueness do
  use Ecto.Migration

  def change do
    create unique_index(:likes, [:user_id, :post_id], name: :friends_uniqueness)
  end
end
