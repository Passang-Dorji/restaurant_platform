defmodule RestaurantPlatform.Order_lists.Order_list do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_lists" do
    field :quantity, :integer
    field :total_prices, :decimal
    belongs_to :order, RestaurantPlatform.Orders.Order, foreign_key: :order_id, references: :id
    belongs_to :menu_item, RestaurantPlatform.MenuItems.MenuItem, foreign_key: :menu_item_id, references: :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order_list, attrs) do
    order_list
    |> cast(attrs, [:quantity, :total_prices, :order_id, :menu_item_id])
    |> validate_required([:quantity, :total_prices, :order_id, :menu_item_id])
  end
end
