defmodule Social.User do
  use Social.Web, :model

  @moduledoc """
  A user consists of a username, hashed password, and an email
  """

  schema "users" do
    field :username, :string, null: false
    field :virtual_password, :string, virtual: true
    field :password, :string, null: false
    field :email, :string

    has_many :posts, Social.Post

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |>cast(params, [:username, :email])
    |>validate_required([:username, :email])
    |>unique_constraint(:username)
  end

  def registration_changeset(struct, params) do
    struct
    |>changeset(params)
    |>cast(params, [:virtual_password])
    |>validate_required([:virtual_password])
    |>validate_length(:virtual_password, min: 6, max: 100)
    |>put_pass_hash
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{virtual_password: pass}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end

