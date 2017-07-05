defmodule Social.UserTest do
  use Social.ModelCase, async: true
  alias Social.User

  @valid_attrs %{username: "username", virtual_password: "password", email: "email"}
  @invalid_attrs %{}

  test "changeset with valid_attrs" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset without email" do
    changeset = User.changeset(%User{} , Map.delete(@valid_attrs, :email))
    assert changeset.valid?
  end

  test "changeset with invalid_attrs" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    assert !changeset.valid?
  end
  
  test "registration changeset with virtual_password < 6 character" do
    changeset = User.registration_changeset(%User{}, Map.put(@valid_attrs, :virtual_password, "pass"))
    assert !changeset.valid?
  end

  test "registration changeset with valid_attrs hashes virtual_password" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)

    assert changeset.valid?
    assert changeset.changes.password
    assert Comeonin.Bcrypt.checkpw(changeset.changes.virtual_password, changeset.changes.password)
  end
end
