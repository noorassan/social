defmodule Social.User do
  use Social.Web, :model

  schema "users" do
    field :username, :string, null: false
    field :virtual_password, :string, virtual: true
    field :password, :string, null: false
    field :email, :string

    has_many :posts, Social.Post
    has_many :friends, Social.Friends

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |>cast(params, [:username, :email])
    |>validate_required([:username])
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

  def preload_friends(query, user_id) do
    from usr in query,
      where: usr.id == ^user_id,
      left_join: f in Social.Friends, on: f.user_id == usr.id,
      left_join: f_usr in Social.User, on: f.friend_id == f_usr.id,
      preload: [friends: {f, friend: f_usr}]
  end

  def preload_friends_by_user_id(query, user_id) do
    from usr in query,
      left_join: f in Social.Friends, on: f.user_id == ^user_id && f.friend_id == usr.id,
      preload: [friends: f]
  end
end
