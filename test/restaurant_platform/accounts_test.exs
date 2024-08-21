defmodule RestaurantPlatform.AccountsTest do
  use RestaurantPlatform.DataCase

  alias RestaurantPlatform.Accounts

  describe "accounts" do
    alias RestaurantPlatform.Accounts.Account

    import RestaurantPlatform.AccountsFixtures

    @invalid_attrs %{name: nil, email: nil, subcribed_at: nil, salt: nil, hash_password: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{name: "some name", email: "some email", subcribed_at: ~U[2024-08-20 04:31:00Z], salt: "some salt", hash_password: "some hash_password"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.name == "some name"
      assert account.email == "some email"
      assert account.subcribed_at == ~U[2024-08-20 04:31:00Z]
      assert account.salt == "some salt"
      assert account.hash_password == "some hash_password"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{name: "some updated name", email: "some updated email", subcribed_at: ~U[2024-08-21 04:31:00Z], salt: "some updated salt", hash_password: "some updated hash_password"}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.name == "some updated name"
      assert account.email == "some updated email"
      assert account.subcribed_at == ~U[2024-08-21 04:31:00Z]
      assert account.salt == "some updated salt"
      assert account.hash_password == "some updated hash_password"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
