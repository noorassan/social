defmodule Social.PostTest do
  use Social.ModelCase, async: true
  alias Social.Post

  @valid_attrs %{message: "message", user_id: 1}
  @invalid_attrs %{}

  test "changeset with valid_attrs" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid_attrs" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
