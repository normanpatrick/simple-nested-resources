defmodule SimpleNestedResourcesWeb.PostControllerTest do
  use SimpleNestedResourcesWeb.ConnCase

  alias SimpleNestedResources.PostContext
  alias SimpleNestedResources.PostContext.Post

  @create_attrs %{
    content: "some content",
    is_active: true,
    title: "some title"
  }
  @update_attrs %{
    content: "some updated content",
    is_active: false,
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, is_active: nil, title: nil}

  def fixture(:post) do
    {:ok, post} = PostContext.create_post(@create_attrs)
    post
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      user_id = 42
      conn = get(conn, Routes.user_post_path(conn, :index, user_id))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      user_id = 42
      conn = post(conn, Routes.user_post_path(conn, :create, user_id),
        post: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_post_path(conn, :show, user_id, id))

      assert %{
               "id" => id,
               "content" => "some content",
               "is_active" => true,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user_id = 42
      conn = post(conn,
        Routes.user_post_path(conn, :create, user_id),
        post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      user_id = 42
      conn = put(conn,
        Routes.user_post_path(conn, :update, user_id, post),
        post: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_post_path(conn, :show, user_id, id))
      assert %{
               "id" => id,
               "content" => "some updated content",
               "is_active" => false,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      user_id = 42
      conn = put(conn,
        Routes.user_post_path(conn, :update, user_id, post),
        post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    @tag skip: "wahoo - not ready yet"
    test "deletes chosen post", %{conn: conn, post: post} do
      user_id = 42
      post_id = "e3583f87-07e8-47b7-9f6c-31ee7ffd3627"
      conn = delete(conn, Routes.user_post_path(conn, :delete, user_id, post_id))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_post_path(conn, :show, user_id, post))
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    {:ok, post: post}
  end
end
