defmodule RestaurantPlatform.Repo.Migrations.RenameSubcribedAtToSubscribedAt do
  use Ecto.Migration

  def change do
    rename table(:accounts), :subcribed_at, to: :subscribed_at
  end
end
