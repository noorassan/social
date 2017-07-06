defmodule Social.UserRepoTest do
  use Social.ModelCase, async: true
  alias Social.User

  @valid_attrs %{username: "username", virtual_password: "password", email: "email"}
  @invalid_attrs %{}

  test "insert changeset with valid_attrs" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert {:ok, _user} = Repo.insert(changeset)
  end
  
  test "insert changest with invalid_attrs" do
    changeset = User.registration_changeset(%User{}, @invalid_attrs)
    assert {:error, _changeset} = Repo.insert(changeset)
  end
end
