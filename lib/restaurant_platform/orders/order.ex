defmodule RestaurantPlatform.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :ordered_at, :utc_datetime
    field :payed_at, :utc_datetime
    field :total_amount, :decimal
    belongs_to :session, RestaurantPlatform.Sessions.Session, foreign_key: :session_id, references: :id
    has_many :order_lists, RestaurantPlatform.Order_lists.Order_list
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)
    order
    |> cast(attrs, [:payed_at, :total_amount, :session_id])
    |> put_change(:ordered_at, now)
    |> validate_required([:total_amount, :session_id])
  end
end
