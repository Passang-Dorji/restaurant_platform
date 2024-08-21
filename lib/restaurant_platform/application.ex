defmodule RestaurantPlatform.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RestaurantPlatformWeb.Telemetry,
      RestaurantPlatform.Repo,
      {DNSCluster, query: Application.get_env(:restaurant_platform, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RestaurantPlatform.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RestaurantPlatform.Finch},
      # Start a worker by calling: RestaurantPlatform.Worker.start_link(arg)
      # {RestaurantPlatform.Worker, arg},
      # Start to serve requests, typically the last entry
      RestaurantPlatformWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RestaurantPlatform.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RestaurantPlatformWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
