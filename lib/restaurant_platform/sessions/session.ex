defmodule RestaurantPlatform.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:id, :session_token, :start_time, :end_time, :table_id]}

  schema "sessions" do
    field :session_token, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    belongs_to :table, RestaurantPlatform.Tables.Table, foreign_key: :table_id, references: :id
    has_many :orders, RestaurantPlatform.Orders.Order
    timestamps(type: :utc_datetime)
  end

   def changeset(session, attrs) do
    session
    |> cast(attrs, [:session_token, :start_time, :end_time, :table_id])
    |> validate_required([:session_token, :start_time, :end_time, :table_id])
    |> foreign_key_constraint(:table_id, name: :sessions_table_id_fkey)
  end
end
