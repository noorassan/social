defmodule Social.Router do
  use Social.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Social.Auth, repo: Social.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Social do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/post", PostController
    resources "/user", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Social do
  #   pipe_through :api
  # end
end
