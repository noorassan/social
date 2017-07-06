defmodule Social.PostController do
  use Social.Web, :controller
  alias Social.Post
  import Social.Auth
  plug :authenticate_user

  def index(conn, _params) do
    render conn, "index.html", posts: Repo.all(Post)
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Post.changeset(%Post{})
  end

  def create(conn, %{"post" => message}) do
    user_id = get_session(conn, :user_id)

    changeset = Post.changeset(%Post{}, Map.merge(message, %{"user_id" => user_id}))

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |>put_flash(:info, "Post created!")
        |>redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    Repo.get!(Post, id)
    |> Repo.delete!()

    conn
    |>put_flash(:info, "Post successfully deleted!")
    |>redirect(to: post_path(conn, :index))
  end
end
