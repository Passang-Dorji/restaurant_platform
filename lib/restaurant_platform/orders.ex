defmodule RestaurantPlatform.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias RestaurantPlatform.Repo

  alias RestaurantPlatform.Orders.Order
  alias RestaurantPlatform.Order_lists.Order_list
  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # def create_order(attrs \\ %{}) do
  #   %Order{}
  #   |> Order.changeset(attrs)
  #   |> Repo.insert()
  # end

  def create_order_with_lists(%{"order" => order_attrs}) do
    Repo.transaction(fn ->
      # Create the order
      order_data = %{
        session_id: order_attrs["session_id"],
        total_amount: order_attrs["total_amount"]
      }
      order_changeset = Order.changeset(%Order{}, order_data)
      {:ok, order} = Repo.insert(order_changeset)

      # Create the order lists
      Enum.each(order_attrs["order_lists"], fn list ->
        order_list_attrs = %{
          order_id: order.id,
          menu_item_id: list["menu_item_id"],
          quantity: list["quantity"],
          total_prices: list["total_prices"]
        }
        order_list_changeset = Order_list.changeset(%Order_list{}, order_list_attrs)
        Repo.insert!(order_list_changeset)
      end)
      order
    end)
  end
  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end
end
