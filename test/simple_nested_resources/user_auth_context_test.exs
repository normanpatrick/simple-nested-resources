defmodule SimpleNestedResources.UserAuthContextTest do
  use SimpleNestedResources.DataCase

  alias SimpleNestedResources.UserAuthContext

  describe "users" do
    alias SimpleNestedResources.UserAuthContext.User

    @valid_attrs %{description: "some description", is_active: true, name: "some name"}
    @update_attrs %{description: "some updated description", is_active: false, name: "some updated name"}
    @invalid_attrs %{description: nil, is_active: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserAuthContext.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert UserAuthContext.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert UserAuthContext.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = UserAuthContext.create_user(@valid_attrs)
      assert user.description == "some description"
      assert user.is_active == true
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserAuthContext.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = UserAuthContext.update_user(user, @update_attrs)
      assert user.description == "some updated description"
      assert user.is_active == false
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = UserAuthContext.update_user(user, @invalid_attrs)
      assert user == UserAuthContext.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = UserAuthContext.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserAuthContext.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = UserAuthContext.change_user(user)
    end
  end
end
