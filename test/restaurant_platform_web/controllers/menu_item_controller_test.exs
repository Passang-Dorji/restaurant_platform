defmodule RestaurantPlatformWeb.MenuItemControllerTest do
  use RestaurantPlatformWeb.ConnCase

  import RestaurantPlatform.MenuItemsFixtures

  alias RestaurantPlatform.MenuItems.MenuItem

  @create_attrs %{
    item_name: "some item_name",
    item_description: "some item_description",
    price: "120.5",
    dish_photo_link: "some dish_photo_link"
  }
  @update_attrs %{
    item_name: "some updated item_name",
    item_description: "some updated item_description",
    price: "456.7",
    dish_photo_link: "some updated dish_photo_link"
  }
  @invalid_attrs %{item_name: nil, item_description: nil, price: nil, dish_photo_link: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all menu_items", %{conn: conn} do
      conn = get(conn, ~p"/api/menu_items")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create menu_item" do
    test "renders menu_item when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/menu_items", menu_item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/menu_items/#{id}")

      assert %{
               "id" => ^id,
               "dish_photo_link" => "some dish_photo_link",
               "item_description" => "some item_description",
               "item_name" => "some item_name",
               "price" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/menu_items", menu_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update menu_item" do
    setup [:create_menu_item]

    test "renders menu_item when data is valid", %{conn: conn, menu_item: %MenuItem{id: id} = menu_item} do
      conn = put(conn, ~p"/api/menu_items/#{menu_item}", menu_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/menu_items/#{id}")

      assert %{
               "id" => ^id,
               "dish_photo_link" => "some updated dish_photo_link",
               "item_description" => "some updated item_description",
               "item_name" => "some updated item_name",
               "price" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, menu_item: menu_item} do
      conn = put(conn, ~p"/api/menu_items/#{menu_item}", menu_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete menu_item" do
    setup [:create_menu_item]

    test "deletes chosen menu_item", %{conn: conn, menu_item: menu_item} do
      conn = delete(conn, ~p"/api/menu_items/#{menu_item}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/menu_items/#{menu_item}")
      end
    end
  end

  defp create_menu_item(_) do
    menu_item = menu_item_fixture()
    %{menu_item: menu_item}
  end
end
