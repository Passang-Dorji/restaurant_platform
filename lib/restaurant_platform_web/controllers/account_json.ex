defmodule RestaurantPlatformWeb.AccountJSON do
  alias RestaurantPlatform.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      name: account.name,
      email: account.email,
      subscribed_at: account.subscribed_at,
      salt: account.salt,
      hash_password: account.hash_password
    }
  end
end
