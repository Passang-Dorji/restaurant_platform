defmodule RestaurantPlatform.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantPlatform.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hash_password: "some hash_password",
        name: "some name",
        salt: "some salt",
        subcribed_at: ~U[2024-08-20 04:31:00Z]
      })
      |> RestaurantPlatform.Accounts.create_account()

    account
  end
end
