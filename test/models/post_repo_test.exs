defmodule Social.PostRepoTest do
  use Social.ModelCase, async: true
  alias Social.Post

  test "insert valid changeset" do
    {:ok, user} = Social.User.registration_changeset(%Social.User{}, %{username: "username", virtual_password: "password"}) |> Repo.insert

    changeset = Post.changeset(%Post{}, %{message: "message", user_id: user.id})
    assert {:ok, _post} = Repo.insert(changeset)    
  end

  test "insert invalid changeset" do
    changeset = Post.changeset(%Post{}, %{})
    assert {:error, _changeset} = Repo.insert(changeset)
  end

  test "user must exist" do
    changeset = Post.changeset(%Post{}, %{message: "message", user_id: "1"})
    assert {:error, _changeset} = Repo.insert(changeset)
  end
end
