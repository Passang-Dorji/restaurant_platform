defmodule RestaurantPlatform.Order_lists do
  @moduledoc """
  The Order_lists context.
  """

  import Ecto.Query, warn: false
  alias RestaurantPlatform.Repo

  alias RestaurantPlatform.Order_lists.Order_list

  @doc """
  Returns the list of order_lists.

  ## Examples

      iex> list_order_lists()
      [%Order_list{}, ...]

  """
  def list_order_lists(order_id) do
    Order_list
    |> where([ol], ol.order_id == ^order_id)
    |> Repo.all()
    |> Repo.preload(:menu_item)
    |> IO.inspect(label: "Order_list with preloaded  menu_items:")
  end

  @doc """
  Gets a single order_list.

  Raises `Ecto.NoResultsError` if the Order list does not exist.

  ## Examples

      iex> get_order_list!(123)
      %Order_list{}

      iex> get_order_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_list!(id), do: Repo.get!(Order_list, id)

  @doc """
  Creates a order_list.

  ## Examples

      iex> create_order_list(%{field: value})
      {:ok, %Order_list{}}

      iex> create_order_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_list(attrs \\ %{}) do
    %Order_list{}
    |> Order_list.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_list.

  ## Examples

      iex> update_order_list(order_list, %{field: new_value})
      {:ok, %Order_list{}}

      iex> update_order_list(order_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_list(%Order_list{} = order_list, attrs) do
    order_list
    |> Order_list.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_list.

  ## Examples

      iex> delete_order_list(order_list)
      {:ok, %Order_list{}}

      iex> delete_order_list(order_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_list(%Order_list{} = order_list) do
    Repo.delete(order_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_list changes.

  ## Examples

      iex> change_order_list(order_list)
      %Ecto.Changeset{data: %Order_list{}}

  """
  def change_order_list(%Order_list{} = order_list, attrs \\ %{}) do
    Order_list.changeset(order_list, attrs)
  end
end
