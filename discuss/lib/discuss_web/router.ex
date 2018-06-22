defmodule DiscussWeb.Router do
  use DiscussWeb, :router

  pipeline :browser do
    plug Ueberauth
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DiscussWeb.Plugs.SetUser # module plug
  end

  # pipeline :authenticate_user do
  # end

  pipeline :api do
    plug :accepts, ["json"]
    # plug :cors
  end

  scope "/", DiscussWeb do
    pipe_through :browser # Use the default browser stack

    get "/", TopicController, :index
    resources "/topics", TopicController
  end


  scope "/auth", DiscussWeb do
    pipe_through :browser

    get "/logout", AuthController, :logout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end
end
