defmodule GifteryWeb.CMS.GiftController do
  use GifteryWeb, :controller

  alias Giftery.CMS
  alias Giftery.CMS.Gift

  def index(conn, _params) do
    gifts = CMS.list_gifts()
    render(conn, "index.html", gifts: gifts)
  end

  def new(conn, _params) do
    changeset = CMS.change_gift(%Gift{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gift" => gift_params}) do
    case CMS.create_gift(gift_params) do
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

  def edit(conn, %{"id" => id}) do
    gift = CMS.get_gift!(id)
    changeset = CMS.change_gift(gift)
    render(conn, "edit.html", gift: gift, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gift" => gift_params}) do
    gift = CMS.get_gift!(id)

    case CMS.update_gift(gift, gift_params) do
      {:ok, gift} ->
        conn
        |> put_flash(:info, "Gift updated successfully.")
        |> redirect(to: cms_gift_path(conn, :show, gift))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gift: gift, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gift = CMS.get_gift!(id)
    {:ok, _gift} = CMS.delete_gift(gift)

    conn
    |> put_flash(:info, "Gift deleted successfully.")
    |> redirect(to: cms_gift_path(conn, :index))
  end
end
