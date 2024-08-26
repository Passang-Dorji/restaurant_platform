defmodule RestaurantPlatformWeb.TableJSON do
  alias RestaurantPlatform.Tables.Table

  @doc """
  Renders a list of tables.
  """
  def index(%{tables: tables}) do
    %{data: for(table <- tables, do: data(table))}
  end

  @doc """
  Renders a single table.
  """
  def show(%{table: table}) do
    %{data: data(table)}
  end

  defp data(%Table{} = table) do
    %{
      id: table.id,
      table_no: table.table_no,
      restaurant_id: table.restaurant_id
    }
  end
end
