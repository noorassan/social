defmodule Social.Post do
  use Social.Web, :model

  @required_params [:message, :user_id]

  schema "posts" do
    field :message, :string, null: false
    
    belongs_to :user, Social.User
    has_many :likes, Social.Like

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> foreign_key_constraint(:user_id)
  end

  def preload_likes_by_user_id(query, user_id) do
    from p in query,
      left_join: l in Social.Like, on: l.user_id == ^user_id and l.post_id == p.id,
      preload: [likes: l]
  end
end

