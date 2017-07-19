defmodule Social.LikeController do
  alias Social.{Like}
  use Social.Web, :controller
  import Social.Auth
  plug :authenticate_user

  def create(conn, %{"like" => like_params}) do
    user_id = get_session(conn, :user_id)

    like_params = Map.put(like_params, "user_id", user_id)
    changeset = %Like{}
      |> Like.changeset(like_params)

    case Repo.insert(changeset) do
      {:ok, like} ->
        conn
        |> json(like.id)
      {:error, _changeset} ->
        conn
        |> json(%{"message" => "Something went wrong"})
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Repo.get(Like, id)
    Repo.delete!(like)

    conn
    |> json(like.post_id)
  end
end
