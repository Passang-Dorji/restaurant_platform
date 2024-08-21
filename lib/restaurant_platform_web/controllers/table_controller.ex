defmodule RestaurantPlatformWeb.TableController do
  use RestaurantPlatformWeb, :controller

  alias RestaurantPlatform.Tables
  alias RestaurantPlatform.Tables.Table

  action_fallback RestaurantPlatformWeb.FallbackController

  def index(conn, _params) do
    tables = Tables.list_tables()
    render(conn, :index, tables: tables)
  end

  def create(conn, %{"table" => %{"tables" => tables_params}}) when is_list(tables_params) do
    with {:ok, tables} <- Tables.create_tables(tables_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tables")
      |> render(:index, tables: tables)
    else
      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, reason: reason)
    end
  end

  def create(conn, %{"table" => table_params}) do
    with {:ok, %Table{} = table} <- Tables.create_table(table_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tables/#{table.id}")
      |> render(:show, table: table)
    else
      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, reason: reason)
    end
  end

  def show(conn, %{"id" => id}) do
    table = Tables.get_table!(id)
    render(conn, :show, table: table)
  end

  def update(conn, %{"id" => id, "table" => table_params}) do
    table = Tables.get_table!(id)

    with {:ok, %Table{} = table} <- Tables.update_table(table, table_params) do
      render(conn, :show, table: table)
    end
  end

  def delete(conn, %{"id" => id}) do
    table = Tables.get_table!(id)

    with {:ok, %Table{}} <- Tables.delete_table(table) do
      send_resp(conn, :no_content, "")
    end
  end
end
