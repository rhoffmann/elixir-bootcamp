defmodule DiscussWeb.Router do
  use DiscussWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussWeb do
    pipe_through :browser # Use the default browser stack

    # get "/about", PageController, :about

    get "/", TopicController, :index
    get "/topics", TopicController, :index

    get "/topics/new", TopicController, :new
    post "/topics", TopicController, :create

    get "/topics/:id/edit", TopicController, :edit
    put "/topics/:id", TopicController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end
end
