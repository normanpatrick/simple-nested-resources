defmodule SimpleNestedResourcesWeb.Router do
  use SimpleNestedResourcesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SimpleNestedResourcesWeb do
    pipe_through :api
    resources "/users", UserController do
      resources "/posts", PostController
    end
  end
end
