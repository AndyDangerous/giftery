defmodule GifteryWeb.Plug.RequireExistingAuthor do
  import Plug.Conn
  alias Giftery.CMS

  def init(opts), do: opts

  def call(conn, _) do
    author = CMS.ensure_author_exists(conn.assigns.current_user)
    assign(conn, :current_author, author)
  end
end
