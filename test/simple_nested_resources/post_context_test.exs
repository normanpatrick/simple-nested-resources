defmodule SimpleNestedResources.PostContextTest do
  use SimpleNestedResources.DataCase

  alias SimpleNestedResources.PostContext

  describe "posts" do
    alias SimpleNestedResources.PostContext.Post

    @valid_attrs %{content: "some content", is_active: true, title: "some title"}
    @update_attrs %{content: "some updated content", is_active: false, title: "some updated title"}
    @invalid_attrs %{content: nil, is_active: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PostContext.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert PostContext.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert PostContext.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = PostContext.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.is_active == true
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PostContext.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = PostContext.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.is_active == false
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = PostContext.update_post(post, @invalid_attrs)
      assert post == PostContext.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = PostContext.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> PostContext.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = PostContext.change_post(post)
    end
  end
end
