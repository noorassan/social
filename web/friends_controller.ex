defmodule FriendsController do
  use Social.Web, :controller

  def create(conn, %{"friends" => friend_params}) do
    user_id = get_session(conn, :user_id)

    like_params = Map.put(friends_params, "user_id", user_id)
    changeset = %Friends{}
      |> Friends.changeset(friends_params)

    case Repo.insert(changeset) do
      {:ok, friends} ->
        conn
        |> json(friends.id)
      {:error, _changeset} ->
        conn
        |> json(%{"message" => "Something went wrong"})
    end
  end

  def delete(conn, %{"id" => id}) do
    friends = Repo.get(Friends, id)
    Repo.delete!(friends)

    conn
    |> json(friends.user_id)
  end
end
