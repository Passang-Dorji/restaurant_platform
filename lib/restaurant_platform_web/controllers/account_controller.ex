defmodule RestaurantPlatformWeb.AccountController do
  use RestaurantPlatformWeb, :controller

  alias RestaurantPlatform.Accounts
  alias RestaurantPlatform.Accounts.Account
  alias RestaurantPlatform.Repo

  action_fallback RestaurantPlatformWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def signup(conn, %{"account" => account_params}) do
    case Accounts.register_user(account_params) do
      {:ok, account} ->
        conn
        |> put_status(:created)
        |> json(%{account: account})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, account} ->
        token = Accounts.generate_token(account)
        conn
        |> put_status(:ok)
        |> json(%{token: token, account: account})
      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: message})
    end
  end

  # def create(conn, %{"account" => account_params}) do
  #   with {:ok, %Account{} = account} <- Accounts.create_account(account_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/accounts/#{account}")
  #     |> render(:show, account: account)
  #   end
  # end

  def create(conn, %{"name" => name, "email" => email, "password" => password}) do
    changeset = %Account{}
    |> Account.changeset(%{name: name, email: email, hash_password: password})

    case Repo.insert(changeset) do
      {:ok, _account} ->
        conn
        |> put_status(:created)
        |> json(%{message: "User created successfully"})

      {:error, changeset} ->
        errors = format_errors(changeset)
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: errors})
    end
  end
  defp format_errors(%Ecto.Changeset{errors: errors}) do
    errors
    |> Enum.reduce(%{}, fn {field, {message, _opts}}, acc ->
      Map.update(acc, field, [message], fn existing -> [message | existing] end)
    end)
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
