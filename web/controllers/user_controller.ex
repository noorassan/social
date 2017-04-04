defmodule Social.UserController do
  use Social.Web, :controller
  alias Social.User

  def index(conn, _params) do
    render conn, "index.html", users: Repo.all(User)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |>put_flash(:info, "User successfully created")
        |>redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    Repo.delete_all(from p in Social.Post, where: p.user_id == ^id)

    Repo.get!(User, id)
    |>Repo.delete!()

    conn
    |>put_flash(:info, "User successfully deleted")
    |>redirect(to: user_path(conn, :index))
  end
end
