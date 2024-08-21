defmodule RestaurantPlatformWeb.RestaurantControllerTest do
  use RestaurantPlatformWeb.ConnCase

  import RestaurantPlatform.RestaurantsFixtures

  alias RestaurantPlatform.Restaurants.Restaurant

  @create_attrs %{
    name: "some name",
    address: "some address",
    contact: "some contact"
  }
  @update_attrs %{
    name: "some updated name",
    address: "some updated address",
    contact: "some updated contact"
  }
  @invalid_attrs %{name: nil, address: nil, contact: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all restaurants", %{conn: conn} do
      conn = get(conn, ~p"/api/restaurants")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create restaurant" do
    test "renders restaurant when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/restaurants", restaurant: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/restaurants/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some address",
               "contact" => "some contact",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/restaurants", restaurant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update restaurant" do
    setup [:create_restaurant]

    test "renders restaurant when data is valid", %{conn: conn, restaurant: %Restaurant{id: id} = restaurant} do
      conn = put(conn, ~p"/api/restaurants/#{restaurant}", restaurant: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/restaurants/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "contact" => "some updated contact",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, restaurant: restaurant} do
      conn = put(conn, ~p"/api/restaurants/#{restaurant}", restaurant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete restaurant" do
    setup [:create_restaurant]

    test "deletes chosen restaurant", %{conn: conn, restaurant: restaurant} do
      conn = delete(conn, ~p"/api/restaurants/#{restaurant}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/restaurants/#{restaurant}")
      end
    end
  end

  defp create_restaurant(_) do
    restaurant = restaurant_fixture()
    %{restaurant: restaurant}
  end
end
