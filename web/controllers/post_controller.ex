defmodule Social.PostController do
  use Social.Web, :controller
  alias Social.{Post, Friends, Notification}
  alias Ecto.Multi
  import Social.Auth
  plug :authenticate_user

  def index(conn, _params) do
    posts = Post.preload_likes_by_user_id(Post, get_session(conn, :user_id))
      |> Repo.all()
    render conn, "index.html", posts: posts
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Post.changeset(%Post{})
  end

  def create(conn, %{"post" => post_params}) do
    user_id = get_session(conn, :user_id)
    username = conn.assigns.current_user.username
    friends = Friends.get_users_friends(Friends, user_id) |> Repo.all

    multi = Multi.new
      |> Multi.insert(:post, Post.changeset(%Post{}, Map.merge(post_params, %{"user_id" => user_id})))

    extra = %{inserted_at: Ecto.DateTime.utc, updated_at: Ecto.DateTime.utc}
    fields = Notification.__schema__(:fields) -- [:id]
    structs = Enum.map(friends, fn(friend) -> 
      %Notification{message: "Your friend, #{username}, posted!", user_id: friend.id} 
        |> Map.take(fields)
        |> Map.merge(extra) 
      end)
    
    multi = multi
        |> Multi.insert_all(:notifications, Notification, structs)

    case Repo.transaction(multi) do
      {:ok, %{post: _post, notifications: _notifications}} ->
        conn
        |> put_flash(:info, "Post successfully created!")
        |> redirect(to: post_path(conn, :index))
      {:error, _failed_operation, failed_value, _changes_so_far} ->
        render conn, "new.html", changeset: failed_value
    end
  end

  def delete(conn, %{"id" => id}) do
    Repo.get!(Post, id)
    |> Repo.delete!()

    conn
    |> put_flash(:info, "Post successfully deleted!")
    |> redirect(to: post_path(conn, :index))
  end
end
