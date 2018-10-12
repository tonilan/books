defmodule BooksWeb.PageController do
  use BooksWeb, :controller
  alias Books.Servers

  def index(conn, _params) do
    url = request_host(conn)
    render conn, "index.html", url: url
  end

  # https://books.dsh.li/surge?password=aaa&username=96481
  def surge(conn, %{"username" => username, "password" => password}) do
    url = request_host(conn) <> conn.request_path <> "?" <> conn.query_string
    render conn, "surge.text", url: url, username: username, password: password
  end

  # https://books.dsh.li/ssr?password=aaa&port=96481
  def ssr(conn, %{"port" => port, "password" => password}) do
    text conn, Servers.ssr_text(String.to_integer(port), password)
  end

  def quantumult(conn, %{"port" => port, "password" => password}) do
    ssr_server_text = Servers.quantumult_ssr_text(String.to_integer(port), password)
    render conn, "quantumult.text", password: password, port: port, ssr_server_text: ssr_server_text
  end

  def quantumult_v2(conn, %{"uuid" => uuid} = params) do
    render conn, "quantumult_v2.text", uuid: uuid, params: params
  end

  defp request_host(conn) do
    "#{Atom.to_string(conn.scheme)}://#{conn.host}"
  end
end
