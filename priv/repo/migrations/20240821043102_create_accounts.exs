defmodule RestaurantPlatform.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :subscribed_at, :utc_datetime
      add :hash_password, :string

      timestamps(type: :utc_datetime)
    end
  end
end
