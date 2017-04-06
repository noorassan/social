defmodule Social.Friends do
  use Social.Web, :model
  
  @doc """
  A set of Friends consists of two user_ids
  """
  @required_params [:user_one_id, :user_two_id]

  schema "friends" do
    belongs_to :user_one, Social.User
    belongs_to :user_two, Social.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |>cast(params, @required_params)
    |>validate_required(@required_params)
    |>foreign_key_constraint(:user_one_id)
    |>foreign_key_constraint(:user_two_id)
  end
end
