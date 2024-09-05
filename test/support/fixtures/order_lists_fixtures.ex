defmodule RestaurantPlatform.Order_listsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantPlatform.Order_lists` context.
  """

  @doc """
  Generate a order_list.
  """
  def order_list_fixture(attrs \\ %{}) do
    {:ok, order_list} =
      attrs
      |> Enum.into(%{
        quantity: 42,
        total_prices: "120.5"
      })
      |> RestaurantPlatform.Order_lists.create_order_list()

    order_list
  end
end
