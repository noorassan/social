defmodule Social.FriendsTest do
  use Social.ModelCase, async: true
  alias Social.Friends

  @valid_attrs %{user_id: 1, friend_id: 2}
  @invalid_attrs %{}

  test "changeset with valid_attrs" do
    changeset = Friends.changeset(%Friends{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid_attrs" do
    changeset = Friends.changeset(%Friends{}, @invalid_attrs)
    refute changeset.valid?
  end
end
