defmodule GifteryWeb.PageController do
  use GifteryWeb, :controller

  plug GifteryWeb.Plug.AuthenticateUser, only: [:welcome]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def welcome(conn, _params) do
    render conn, "welcome.html"
  end
end
