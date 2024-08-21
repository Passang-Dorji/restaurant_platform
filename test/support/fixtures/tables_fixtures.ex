defmodule RestaurantPlatform.TablesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantPlatform.Tables` context.
  """

  @doc """
  Generate a table.
  """
  def table_fixture(attrs \\ %{}) do
    {:ok, table} =
      attrs
      |> Enum.into(%{
        table_no: "some table_no"
      })
      |> RestaurantPlatform.Tables.create_table()

    table
  end
end
