defmodule RestaurantPlatform.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :name, :string
    field :email, :string
    field :subscribed_at, :utc_datetime, default: :nil
    field :salt, :string
    field :hash_password, :string
    has_many :restaurants, RestaurantPlatform.Restaurants.Restaurant
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :email, :subscribed_at, :salt, :hash_password])
    |> validate_required([:name, :email, :salt, :hash_password]) #removed :subscribed_at,
  end
end
