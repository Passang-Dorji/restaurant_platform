defmodule RestaurantPlatformWeb.Order_listJSON do
  alias RestaurantPlatform.Order_lists.Order_list

  @doc """
  Renders a list of order_lists.
  """
  def index(%{order_lists: order_lists}) do
    %{data: for(order_list <- order_lists, do: data(order_list))}
  end

  @doc """
  Renders a single order_list.
  """
  def show(%{order_list: order_list}) do
    %{data: data(order_list)}
  end

  defp data(%Order_list{} = order_list) do
    %{
      id: order_list.id,
      quantity: order_list.quantity,
      total_prices: order_list.total_prices,
      item_name: order_list.menu_item.item_name,
      price: order_list.menu_item.price
    }
  end
end
