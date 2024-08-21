defmodule RestaurantPlatform.Repo do
  use Ecto.Repo,
    otp_app: :restaurant_platform,
    adapter: Ecto.Adapters.Postgres
end
