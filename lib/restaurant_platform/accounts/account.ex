defmodule RestaurantPlatform.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :email, :subscribed_at]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :name, :string
    field :email, :string
    field :subscribed_at, :utc_datetime, default: :nil
    field :hash_password, :string
    has_many :restaurants, RestaurantPlatform.Restaurants.Restaurant
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :email, :subscribed_at, :hash_password])
    |> validate_required([:name, :email,  :hash_password]) #removed :subscribed_at,:salt,
    |> validate_format(:email, ~r/@/)
    |> validate_length(:hash_password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :hash_password) do
      nil -> changeset
      password ->
        hash_password = Bcrypt.hash_pwd_salt(password)
        put_change(changeset, :hash_password, hash_password)
    end
  end
end
