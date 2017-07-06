defmodule Social.Post do
  use Social.Web, :model

  @required_params [:message, :user_id]

  schema "posts" do
    field :message, :string, null: false
    belongs_to :user, Social.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |>cast(params, @required_params)
    |>validate_required(@required_params)
    |>foreign_key_constraint(:user_id)
  end
end

