defmodule Social.LikeRepoTest do
  use Social.ModelCase, async: true
  alias Social.Like

  test "insert valid changeset" do
    {:ok, user} = Social.User.registration_changeset(%Social.User{}, %{username: "username", virtual_password: "password"}) 
      |> Repo.insert

    {:ok, post} = Social.Post.changeset(%Social.Post{}, %{message: "message", user_id: user.id})
      |> Repo.insert

    changeset = Like.changeset(%Like{}, %{post_id: post.id, user_id: user.id})
    assert {:ok, _like} = Repo.insert(changeset)    
  end

  test "insert invalid changeset" do
    changeset = Like.changeset(%Social.Like{}, %{})
    assert {:error, _changeset} = Repo.insert(changeset)
  end

  test "user must exist" do
    {:ok, user} = Social.User.registration_changeset(%Social.User{}, %{username: "username", virtual_password: "password"}) 
      |> Repo.insert

    {:ok, post} = Social.Post.changeset(%Social.Post{}, %{message: "message", user_id: user.id})
      |> Repo.insert

    changeset = Like.changeset(%Like{}, %{post_id: post.id, user_id: "1"})
    assert {:error, _changeset} = Repo.insert(changeset)
  end

  test "post must exist" do
    {:ok, user} = Social.User.registration_changeset(%Social.User{}, %{username: "username", virtual_password: "password"})
      |> Repo.insert

    changeset = Like.changeset(%Like{}, %{post_id: 1, user_id: user.id})
    assert {:error, _changeset} = Repo.insert(changeset)
  end
end
