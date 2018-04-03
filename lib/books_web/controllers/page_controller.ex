defmodule BooksWeb.PageController do
  use BooksWeb, :controller
  alias Books.Servers

  def index(conn, _params) do
    render conn, "index.html"
  end

  def surge(conn, %{"username" => username, "password" => password}) do
    url = current_url(conn)
    s5_servers = Servers.socks5_tls()
    render conn, "surge.text", url: url, username: username, password: password, s5_servers: s5_servers
  end

  def ssr(conn, %{"port" => port, "password" => password}) do
    text conn, Servers.ssr_text(port, password)
  end
end
