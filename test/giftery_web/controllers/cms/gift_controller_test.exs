defmodule GifteryWeb.CMS.GiftControllerTest do
  use GifteryWeb.ConnCase

  alias Giftery.CMS

  @create_attrs %{available: true, name: "some name", notes: "some notes", url: "some url"}
  @update_attrs %{available: false, name: "some updated name", notes: "some updated notes", url: "some updated url"}
  @invalid_attrs %{available: nil, name: nil, notes: nil, url: nil}

  def fixture(:gift) do
    {:ok, gift} = CMS.create_gift(@create_attrs)
    gift
  end

  describe "index" do
    test "lists all gifts", %{conn: conn} do
      conn = get conn, cms_gift_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Gifts"
    end
  end

  describe "new gift" do
    test "renders form", %{conn: conn} do
      conn = get conn, cms_gift_path(conn, :new)
      assert html_response(conn, 200) =~ "New Gift"
    end
  end

  describe "create gift" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, cms_gift_path(conn, :create), gift: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == cms_gift_path(conn, :show, id)

      conn = get conn, cms_gift_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Gift"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, cms_gift_path(conn, :create), gift: @invalid_attrs
      assert html_response(conn, 200) =~ "New Gift"
    end
  end

  describe "edit gift" do
    setup [:create_gift]

    test "renders form for editing chosen gift", %{conn: conn, gift: gift} do
      conn = get conn, cms_gift_path(conn, :edit, gift)
      assert html_response(conn, 200) =~ "Edit Gift"
    end
  end

  describe "update gift" do
    setup [:create_gift]

    test "redirects when data is valid", %{conn: conn, gift: gift} do
      conn = put conn, cms_gift_path(conn, :update, gift), gift: @update_attrs
      assert redirected_to(conn) == cms_gift_path(conn, :show, gift)

      conn = get conn, cms_gift_path(conn, :show, gift)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, gift: gift} do
      conn = put conn, cms_gift_path(conn, :update, gift), gift: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Gift"
    end
  end

  describe "delete gift" do
    setup [:create_gift]

    test "deletes chosen gift", %{conn: conn, gift: gift} do
      conn = delete conn, cms_gift_path(conn, :delete, gift)
      assert redirected_to(conn) == cms_gift_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, cms_gift_path(conn, :show, gift)
      end
    end
  end

  defp create_gift(_) do
    gift = fixture(:gift)
    {:ok, gift: gift}
  end
end
