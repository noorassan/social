defmodule Social.Like do
  use Social.Web, :model
  
  @required_params [:user_id, :post_id]

  schema "likes" do
    belongs_to :user, Social.User
    belongs_to :post, Social.Post

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:post_id)
    |> unique_constraint(:like_unique_constraint, name: :like_uniqueness)
  end
end
