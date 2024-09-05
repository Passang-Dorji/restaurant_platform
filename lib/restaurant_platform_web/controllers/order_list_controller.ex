defmodule RestaurantPlatformWeb.Order_listController do
  use RestaurantPlatformWeb, :controller

  alias RestaurantPlatform.Order_lists
  alias RestaurantPlatform.Order_lists.Order_list

  action_fallback RestaurantPlatformWeb.FallbackController

  def index(conn, _params) do
    order_lists = Order_lists.list_order_lists()
    render(conn, :index, order_lists: order_lists)
  end

  def create(conn, %{"order_list" => order_list_params}) do
    with {:ok, %Order_list{} = order_list} <- Order_lists.create_order_list(order_list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/order_lists/#{order_list}")
      |> render(:show, order_list: order_list)
    end
  end

  def show(conn, %{"id" => id}) do
    order_list = Order_lists.get_order_list!(id)
    render(conn, :show, order_list: order_list)
  end

  def update(conn, %{"id" => id, "order_list" => order_list_params}) do
    order_list = Order_lists.get_order_list!(id)

    with {:ok, %Order_list{} = order_list} <- Order_lists.update_order_list(order_list, order_list_params) do
      render(conn, :show, order_list: order_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_list = Order_lists.get_order_list!(id)

    with {:ok, %Order_list{}} <- Order_lists.delete_order_list(order_list) do
      send_resp(conn, :no_content, "")
    end
  end
end
