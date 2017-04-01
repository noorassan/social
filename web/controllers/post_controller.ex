defmodule Social.PostController do
  use Social.Web, :controller
  alias Social.Post

  def index(conn, _params) do
    render conn, "index.html", posts: Repo.all(Post)
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: %Post{}
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |>put_flash(:info, "Post created!")
        |>redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
