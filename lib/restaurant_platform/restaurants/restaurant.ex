defmodule RestaurantPlatform.Restaurants.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "restaurants" do
    field :name, :string
    field :address, :string
    field :contact, :string
    belongs_to :account, RestaurantPlatform.Accounts.Account, foreign_key: :account_id, references: :id
    has_many :tables, RestaurantPlatform.Tables.Table
    has_many :menu_items, RestaurantPlatform.MenuItems.MenuItem
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :address, :contact, :account_id])
    |> validate_required([:name, :address, :contact, :account_id])
  end
end
