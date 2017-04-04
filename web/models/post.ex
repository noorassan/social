defmodule Social.Post do
  use Social.Web, :model

  @moduledoc """
  A post consists of a reference to the user that made it and the text it contains
  """
  @required_params [:message, :user_id]

  schema "posts" do
    field :message, :string
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

