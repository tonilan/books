defmodule BooksWeb.PageView do
  use BooksWeb, :view

  def get_surge_nodes("all") do
    "#{s5_nodes},#{ss_nodes}"
  end
  
  def get_surge_nodes("ss") do
    "#{ss_nodes}"
  end

  def get_surge_nodes("s5") do
    "#{s5_nodes}"
  end

  defp s5_nodes do
    Enum.map_join(Books.Servers.socks5_tls(), ", ", fn s -> s.name end)
  end
  defp ss_nodes do
    Enum.map_join(Books.Servers.ss_server(), ", ", fn s -> "#{s.name} Shadowsocks" end)
  end
end
