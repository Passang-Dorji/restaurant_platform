defmodule RestaurantPlatformWeb.MenuItemController do
  use RestaurantPlatformWeb, :controller

  alias RestaurantPlatform.MenuItems
  alias RestaurantPlatform.MenuItems.MenuItem

  action_fallback RestaurantPlatformWeb.FallbackController

  def index(conn, _params) do
    menu_items = MenuItems.list_menu_items()
    render(conn, :index, menu_items: menu_items)
  end

  # def create(conn, %{"menu_item" => menu_item_params}) do
  #   with {:ok, %MenuItem{} = menu_item} <- MenuItems.create_menu_item(menu_item_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/menu_items/#{menu_item}")
  #     |> render(:show, menu_item: menu_item)
  #   end
  # end
  def create(conn, %{"menu_item" => %{"menu_items" => menu_item_params}}) when is_list(menu_item_params) do
    with {:ok, menu_items} <- MenuItems.create_menu_items(menu_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/menu_items")
      |> render(:index, menu_items: menu_items)
    else
      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, reason: reason)
    end
  end

  def create(conn, %{"menu_item" => menu_item_params}) do
    with {:ok, %MenuItem{} = menu_item} <- MenuItems.create_menu_item(menu_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/menu_items/#{menu_item.id}")
      |> render(:show, menu_item: menu_item)
    else
      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, reason: reason)
    end
  end

  def show(conn, %{"id" => id}) do
    menu_item = MenuItems.get_menu_item!(id)
    render(conn, :show, menu_item: menu_item)
  end

  def update(conn, %{"id" => id, "menu_item" => menu_item_params}) do
    menu_item = MenuItems.get_menu_item!(id)

    with {:ok, %MenuItem{} = menu_item} <- MenuItems.update_menu_item(menu_item, menu_item_params) do
      render(conn, :show, menu_item: menu_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    menu_item = MenuItems.get_menu_item!(id)

    with {:ok, %MenuItem{}} <- MenuItems.delete_menu_item(menu_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
