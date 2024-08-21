defmodule RestaurantPlatform.Tables.Table do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tables" do
    field :table_no, :string
    belongs_to :restaurant, RestaurantPlatform.Restaurants.Restaurant, foreign_key: :restaurant_id, references: :id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(table, attrs) do
    table
    |> cast(attrs, [:table_no])
    |> validate_required([:table_no])
  end
end
