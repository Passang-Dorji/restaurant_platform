defmodule RestaurantPlatform.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantPlatform.Restaurants` context.
  """

  @doc """
  Generate a restaurant.
  """
  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
        address: "some address",
        contact: "some contact",
        name: "some name"
      })
      |> RestaurantPlatform.Restaurants.create_restaurant()

    restaurant
  end
end
