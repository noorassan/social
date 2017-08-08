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
    plug :fetch_session
    plug Social.Auth, repo: Social.Repo
  end

  scope "/", Social do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/post", PostController
    resources "/user", UserController
    resources "/session", SessionController, only: [:new, :create, :delete]
    resources "/notification", NotificationController, only: [:delete]
  end

  scope "/api", Social do
    pipe_through :api
    
    resources "/like", LikeController, only: [:create, :delete]
    resources "/friends", FriendsController, only: [:create, :delete]
   end
end
