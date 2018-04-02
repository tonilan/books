defmodule BooksWeb.PageController do
  use BooksWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
