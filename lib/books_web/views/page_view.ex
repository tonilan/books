defmodule BooksWeb.PageView do
  use BooksWeb, :view

  def ss_nodes do
    Enum.map_join(Books.Servers.ss_server(), ", ", fn s -> s.name end)
  end
end
