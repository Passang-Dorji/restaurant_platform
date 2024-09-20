defmodule RestaurantPlatformWeb.OrderJSON do
  alias RestaurantPlatform.Orders.Order
  alias RestaurantPlatform.Repo

  @doc """
  Renders a list of orders.
  """
  def index(%{orders: orders}) do
    %{data: for(order <- orders, do: data(order))}
  end

  @doc """
  Renders a single order.
  """
  def show(%{order: order}) do
    %{data: data(order)}
  end

  defp data(%Order{} = order) do
    order = Repo.preload(order, session: :table)
    table_no =
    case order.session do
      nil -> nil
      session -> session.table.table_no
    end
    %{
      id: order.id,
      ordered_at: order.ordered_at,
      payed_at: order.payed_at,
      total_amount: order.total_amount,
      session_id: order.session_id,
      table_no: table_no
    }
  end
end
