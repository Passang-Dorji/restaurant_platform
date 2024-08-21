defmodule RestaurantPlatform.TablesTest do
  use RestaurantPlatform.DataCase

  alias RestaurantPlatform.Tables

  describe "tables" do
    alias RestaurantPlatform.Tables.Table

    import RestaurantPlatform.TablesFixtures

    @invalid_attrs %{table_no: nil}

    test "list_tables/0 returns all tables" do
      table = table_fixture()
      assert Tables.list_tables() == [table]
    end

    test "get_table!/1 returns the table with given id" do
      table = table_fixture()
      assert Tables.get_table!(table.id) == table
    end

    test "create_table/1 with valid data creates a table" do
      valid_attrs = %{table_no: "some table_no"}

      assert {:ok, %Table{} = table} = Tables.create_table(valid_attrs)
      assert table.table_no == "some table_no"
    end

    test "create_table/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tables.create_table(@invalid_attrs)
    end

    test "update_table/2 with valid data updates the table" do
      table = table_fixture()
      update_attrs = %{table_no: "some updated table_no"}

      assert {:ok, %Table{} = table} = Tables.update_table(table, update_attrs)
      assert table.table_no == "some updated table_no"
    end

    test "update_table/2 with invalid data returns error changeset" do
      table = table_fixture()
      assert {:error, %Ecto.Changeset{}} = Tables.update_table(table, @invalid_attrs)
      assert table == Tables.get_table!(table.id)
    end

    test "delete_table/1 deletes the table" do
      table = table_fixture()
      assert {:ok, %Table{}} = Tables.delete_table(table)
      assert_raise Ecto.NoResultsError, fn -> Tables.get_table!(table.id) end
    end

    test "change_table/1 returns a table changeset" do
      table = table_fixture()
      assert %Ecto.Changeset{} = Tables.change_table(table)
    end
  end
end
