defmodule RestaurantPlatformWeb.RestaurantJSON do
  alias RestaurantPlatform.Restaurants.Restaurant

  @doc """
  Renders a list of restaurants.
  """
  def index(%{restaurants: restaurants}) do
    %{data: for(restaurant <- restaurants, do: data(restaurant))}
  end

  @doc """
  Renders a single restaurant.
  """
  def show(%{restaurant: restaurant}) do
    %{data: data(restaurant)}
  end

  defp data(%Restaurant{} = restaurant) do
    %{
      id: restaurant.id,
      name: restaurant.name,
      address: restaurant.address,
      contact: restaurant.contact,
      account_id: restaurant.account_id
    }
  end
end
