defmodule Social.FriendsRepoTest do
  use Social.ModelCase, async: true
  alias Social.Friends
  alias Social.User

  setup do
    {:ok, user1} = User.registration_changeset(%User{}, %{username: "name", virtual_password: "password"}) |> Repo.insert
    {:ok, user2} = User.registration_changeset(%User{}, %{username: "name", virtual_password: "password"}) |> Repo.insert

    %{user: user1, friend: user2}
  end

  test "insert valid changeset", %{user: user1, friend: user2}  do
    changeset = Friends.changeset(%Friends{}, %{user_id: user1.id, friend_id: user2.id})
    assert {:ok, _friends} = Repo.insert(changeset)
  end

  test "insert invalid changeset" do
    changeset = Friends.changeset(%Friends{}, %{})
    assert {:error, _changeset} = Repo.insert(changeset)
  end

  test "user must exist", %{friend: user2} do
    changeset = Friends.changeset(%Friends{}, %{user_id: 9999, friend_id: user2.id})
    assert {:error, _changeset} = Repo.insert(changeset)
  end

  test "friend must exist", %{user: user1} do
    changeset = Friends.changeset(%Friends{}, %{user_id: user1.id, friend_id: 9999})
    assert {:error, _changeset} = Repo.insert(changeset)
  end
end
