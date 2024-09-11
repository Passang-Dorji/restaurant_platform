defmodule RestaurantPlatform.MenuItems.MenuItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_items" do
    field :item_name, :string
    field :item_description, :string
    field :price, :decimal
    field :dish_photo_link, :string
    belongs_to :restaurant, RestaurantPlatform.Restaurants.Restaurant, foreign_key: :restaurant_id, references: :id
    has_many :order_lists, RestaurantPlatform.Order_lists.Order_list
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(menu_item, attrs) do
    menu_item
    |> cast(attrs, [:item_name, :item_description, :price, :dish_photo_link, :restaurant_id])
    |> validate_required([:item_name, :item_description, :price, :dish_photo_link, :restaurant_id])
  end
end
