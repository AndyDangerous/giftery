defmodule GifteryWeb.CMS.GiftController do
  use GifteryWeb, :controller

  alias Giftery.CMS
  alias Giftery.CMS.Gift

  plug GifteryWeb.Plug.RequireExistingAuthor
  plug :authorize_gift when action in [:edit, :update, :delete]

  def index(conn, _params) do
    author = conn.assigns.current_author
    gifts = CMS.list_gifts(author)
    render(conn, "index.html", gifts: gifts)
  end

  def new(conn, _params) do
    changeset = CMS.change_gift(%Gift{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gift" => gift_params}) do
    case CMS.create_gift(conn.assigns.current_author, gift_params) do
      {:ok, gift} ->
        conn
        |> put_flash(:info, "Gift created successfully.")
        |> redirect(to: cms_gift_path(conn, :show, gift))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gift = CMS.get_gift!(id)
    render(conn, "show.html", gift: gift)
  end

  def edit(conn, _) do
    changeset = CMS.change_gift(conn.assigns.gift)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"gift" => gift_params}) do
    case CMS.update_gift(conn.assigns.gift, gift_params) do
      {:ok, gift} ->
        conn
        |> put_flash(:info, "Gift updated successfully.")
        |> redirect(to: cms_gift_path(conn, :show, gift))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _) do
    {:ok, _gift} = CMS.delete_gift(conn.assigns.gift)

    conn
    |> put_flash(:info, "Gift deleted successfully.")
    |> redirect(to: cms_gift_path(conn, :index))
  end

  defp authorize_gift(conn, _) do
    gift = CMS.get_gift!(conn.params["id"])

    if conn.assigns.current_author.id == gift.author_id do
      assign(conn, :gift, gift)
    else
      conn
      |> put_flash(:error, "You can't modify that gift")
      |> redirect(to: cms_gift_path(conn, :index))
      |> halt()
    end
  end
end
