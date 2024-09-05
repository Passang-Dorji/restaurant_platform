defmodule RestaurantPlatform.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantPlatform.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        ordered_at: ~U[2024-08-27 07:29:00Z],
        payed_at: ~U[2024-08-27 07:29:00Z],
        total_amount: "120.5"
      })
      |> RestaurantPlatform.Orders.create_order()

    order
  end
end
