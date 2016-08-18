defmodule WeatherBot.Router do
  use WeatherBot.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :webhook do
    plug :accepts, ["text", "html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WeatherBot do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/bots", BotController, except: [:index]
  end

  scope "/ask", WeatherBot do
    pipe_through :webhook
    post "/", BotController, :ask
  end

  # Other scopes may use custom stacks.
  # scope "/api", WeatherBot do
  #   pipe_through :api
  # end
end
