defmodule Social.Repo.Migrations.EnsureLikeUniqueness do
  use Ecto.Migration

  def change do
    create unique_index(:likes, [:user_id, :post_id], name: :like_uniqueness)
  end
end
