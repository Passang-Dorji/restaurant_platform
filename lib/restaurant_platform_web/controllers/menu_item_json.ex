defmodule RestaurantPlatformWeb.MenuItemJSON do
  alias RestaurantPlatform.MenuItems.MenuItem

  @doc """
  Renders a list of menu_items.
  """
  def index(%{menu_items: menu_items}) do
    %{data: for(menu_item <- menu_items, do: data(menu_item))}
  end

  @doc """
  Renders a single menu_item.
  """
  def show(%{menu_item: menu_item}) do
    %{data: data(menu_item)}
  end

  defp data(%MenuItem{} = menu_item) do
    %{
      id: menu_item.id,
      item_name: menu_item.item_name,
      item_description: menu_item.item_description,
      price: menu_item.price,
      dish_photo_link: menu_item.dish_photo_link
    }
  end
end
