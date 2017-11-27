defmodule GifteryWeb.Router do
  use GifteryWeb, :router

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

  pipeline :auth do
    plug GifteryWeb.Plug.AuthenticateUser
  end

  scope "/", GifteryWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/welcome", PageController, :welcome

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                                     singleton: true
  end

  scope "/cms", GifteryWeb.CMS, as: :cms do
    pipe_through [:browser, :auth]

    resources "/gifts", GiftController
    resources "/pages", PageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GifteryWeb do
  #   pipe_through :api
  # end
end
