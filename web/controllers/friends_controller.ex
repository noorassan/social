defmodule Social.FriendsController do
  use Social.Web, :controller
  alias Ecto.Multi
  alias Social.Friends

  def create(conn, %{"friend_id" => friend_id}) do
    user_id = get_session(conn, :user_id)

    changeset_one = %Friends{}
      |> Friends.changeset(%{user_id: user_id, friend_id: friend_id})

    changeset_two = %Friends{}
      |> Friends.changeset(%{user_id: friend_id, friend_id: user_id})
      
    result = Multi.new
      |> Multi.insert(:friends_one, changeset_one)
      |> Multi.insert(:friends_two, changeset_two)
      |> Repo.transaction

    case result do
      {:ok, %{friends_one: friends_one, friends_two: _friends_two}} ->
        conn
        |> json(friends_one.id)
      {:error, _failed_operation, _failed_value, _changes_so_far} ->
        conn
        |> json(%{"message" => "Something went wrong"})
    end
  end

  def delete(conn, %{"id" => id}) do
    friends_one = Repo.get(Friends, id)
    friends_two = Repo.one(Friends.get_paired_friends(Friends, friends_one))

    Multi.new
      |> Multi.delete(:friends_one, friends_one)
      |> Multi.delete(:friends_two, friends_two)
      |> Repo.transaction  

    friend_id = 
      if(friends_one.user_id == get_session(conn, :user_id)) do
        friends_one.friend_id
      else
        friends_one.user_id
      end

    conn
    |> json(friend_id)
  end
end
