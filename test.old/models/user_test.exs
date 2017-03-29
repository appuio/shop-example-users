defmodule DocsUsers.UserTest do
  use DocsUsers.ModelCase

  alias DocsUsers.User

  @valid_attrs %{active: true, email: "some content", name: "some content", password: "some content", uuid: "7488a646-e31f-11e4-aace-600308960662"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
