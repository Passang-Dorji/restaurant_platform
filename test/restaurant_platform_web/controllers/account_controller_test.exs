defmodule RestaurantPlatformWeb.AccountControllerTest do
  use RestaurantPlatformWeb.ConnCase

  import RestaurantPlatform.AccountsFixtures

  alias RestaurantPlatform.Accounts.Account

  @create_attrs %{
    name: "some name",
    email: "some email",
    subcribed_at: ~U[2024-08-20 04:31:00Z],
    salt: "some salt",
    hash_password: "some hash_password"
  }
  @update_attrs %{
    name: "some updated name",
    email: "some updated email",
    subcribed_at: ~U[2024-08-21 04:31:00Z],
    salt: "some updated salt",
    hash_password: "some updated hash_password"
  }
  @invalid_attrs %{name: nil, email: nil, subcribed_at: nil, salt: nil, hash_password: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, ~p"/api/accounts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email",
               "hash_password" => "some hash_password",
               "name" => "some name",
               "salt" => "some salt",
               "subcribed_at" => "2024-08-20T04:31:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "hash_password" => "some updated hash_password",
               "name" => "some updated name",
               "salt" => "some updated salt",
               "subcribed_at" => "2024-08-21T04:31:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, ~p"/api/accounts/#{account}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/accounts/#{account}")
      end
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end
