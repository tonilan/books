defmodule BooksWeb.PageController do
  use BooksWeb, :controller
  alias Books.Servers

  def index(conn, _params) do
    url = request_host(conn)
    render conn, "index.html", url: url
  end

  # https://books.dsh.li/surge?password=aaa&username=96481&type=ss
  def surge(conn, %{"username" => username, "password" => password} = params) do
    url = request_host(conn) <> conn.request_path <> "?" <> conn.query_string
    port = String.to_integer(username)
    type = params["type"] || "all"
    render conn, "surge.text", url: url, port: port, password: password, type: type
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

  def quantumult_ss(conn, %{"port" => port, "password" => password}) do
    user_info = Base.encode64("aes-256-gcm:#{password}")
    port = String.to_integer(port) - 1000
    plugin_params = URI.encode_www_form("simple-obfs;obfs=tls;obfs-host=www.icloud.com")

    str = Servers.ss_server
    |> Enum.map(fn s -> "ss://#{user_info}@#{s.host}:#{port}/?plugin=#{plugin_params}##{s.name} SS" end)
    |> Enum.join("\n") 
    text conn, Base.encode64(str)
  end

  defp request_host(conn) do
    if Mix.env == :dev do
      "#{Atom.to_string(conn.scheme)}://#{conn.host}:4000"
    else
      "#{Atom.to_string(conn.scheme)}://#{conn.host}"
    end 
  end
end
