defmodule Social.Post do
  use Social.Web, :model

  @moduledoc """
  A post consists of a reference to the user that made it and the text it contains
  """
  @required_params [:message, :creator]

  schema "posts" do
    field :message, :string
    field :creator, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end

