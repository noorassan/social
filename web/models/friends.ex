defmodule Social.Friends do
  use Social.Web, :model
  
  @doc """
  A set of Friends consists of two user_ids
  """
  @required_params [:user_id, :friend_id]

  schema "friends" do
    belongs_to :user, Social.User
    belongs_to :friend, Social.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:friend_id)
    |> _ensure_a_user_cannot_friend_itself()
    |> unique_constraint(:friends_unique_constraint, name: :friends_uniqueness)
  end

  defp _ensure_a_user_cannot_friend_itself(changeset) do
    if(changeset.changes.user_id != changeset.changes.friend_id) do
      changeset
    else
      add_error(changeset, :user_id_and_friend_id, "can't be be equal")
    end
  end

  def get_paired_friends(query, friends) do
    from f in query,
      where: f.user_id == ^friends.friend_id,
      where: f.friend_id == ^friends.user_id
  end
end
