defmodule BooksWeb.PageController do
  use BooksWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def surge(conn, %{"username" => username, "password" => password}) do
    url = current_url(conn)
    s5_servers = Books.Servers.socks5_tls()
    render conn, "surge.text", url: url, username: username, password: password, s5_servers: s5_servers
  end
end
