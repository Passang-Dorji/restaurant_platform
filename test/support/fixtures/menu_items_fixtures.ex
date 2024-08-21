defmodule RestaurantPlatform.MenuItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantPlatform.MenuItems` context.
  """

  @doc """
  Generate a menu_item.
  """
  def menu_item_fixture(attrs \\ %{}) do
    {:ok, menu_item} =
      attrs
      |> Enum.into(%{
        dish_photo_link: "some dish_photo_link",
        item_description: "some item_description",
        item_name: "some item_name",
        price: "120.5"
      })
      |> RestaurantPlatform.MenuItems.create_menu_item()

    menu_item
  end
end
