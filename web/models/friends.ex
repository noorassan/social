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
    |>cast(params, @required_params)
    |>validate_required(@required_params)
    |>foreign_key_constraint(:user_id)
    |>foreign_key_constraint(:friend_id)
  end
end
