defmodule BooksWeb.PageController do
  use BooksWeb, :controller
  alias Books.Servers

  def index(conn, _params) do
    render conn, "index.html"
  end

  # https://books.dsh.li/surge?password=aaa&username=96481
  def surge(conn, %{"username" => username, "password" => password}) do
    url = current_url(conn)
    s5_servers = Servers.socks5_tls()
    render conn, "surge.text", url: url, username: username, password: password, s5_servers: s5_servers
  end

  # https://books.dsh.li/ssr?password=aaa&port=96481
  def ssr(conn, %{"port" => port, "password" => password}) do
    text conn, Servers.ssr_text(String.to_integer(port), password)
  end
end
