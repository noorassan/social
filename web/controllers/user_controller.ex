defmodule Social.UserController do
  use Social.Web, :controller
  alias Social.User
  import Social.Auth
  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    user_id = get_session(conn, :user_id)
    users = User.preload_friends_by_user_id(User, user_id)
      |> Repo.all()
    render conn, "index.html", users: users, user_id: user_id
  end

  def show(conn, %{"id" => id}) do
    user = Repo.one(User.preload_friends(User, id))
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    profile_picture_path = 
    if upload = user_params["photo"] do
      extension = Path.extname(upload.filename)
      path = "~/Pictures/social_pictures/#{Map.get(user_params, "username")}-profile#{extension}"
      
      File.cp(upload.path, path)
      
      path
    end
    
    changeset = User.registration_changeset(%User{}, Map.merge(user_params, %{"profile_picture_path" => profile_picture_path}))
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Social.Auth.login(user)
        |> put_flash(:info, "User successfully created")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
  
  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    Repo.delete(user)
    
    File.rm(user.profile_picture_path)
    conn
    |> put_flash(:info, "User successfully deleted")
    |> redirect(to: user_path(conn, :index))
  end
end
