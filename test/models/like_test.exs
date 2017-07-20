defmodule Social.LikeTest do
  use Social.ModelCase, async: true
  alias Social.Like

  @valid_attrs %{post_id: 1, user_id: 1}
  @invalid_attrs %{}

  test "changeset with valid_attrs" do
    changeset = Like.changeset(%Like{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid_attrs" do
    changeset = Like.changeset(%Like{}, @invalid_attrs)
    refute changeset.valid?
  end
end
