defmodule SimpleNestedResourcesWeb.PostController do
  use SimpleNestedResourcesWeb, :controller

  alias SimpleNestedResources.PostContext
  alias SimpleNestedResources.PostContext.Post

  action_fallback SimpleNestedResourcesWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    posts = PostContext.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params, "user_id" => user_id}) do
    with {:ok, %Post{} = post} <- PostContext.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_post_path(
            conn, :show, user_id, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = PostContext.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = PostContext.get_post!(id)

    with {:ok, %Post{} = post} <- PostContext.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id, "user_id" => user_id}) do
    post = PostContext.get_post!(id)

    with {:ok, %Post{}} <- PostContext.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
