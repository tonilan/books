defmodule BooksWeb.Router do
  use BooksWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BooksWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/surge_books", PageController, :surge
  end

  # Other scopes may use custom stacks.
  # scope "/api", BooksWeb do
  #   pipe_through :api
  # end
end
