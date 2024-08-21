defmodule RestaurantPlatform.MenuItems do
  @moduledoc """
  The MenuItems context.
  """

  import Ecto.Query, warn: false
  alias RestaurantPlatform.Repo

  alias RestaurantPlatform.MenuItems.MenuItem

  @doc """
  Returns the list of menu_items.

  ## Examples

      iex> list_menu_items()
      [%MenuItem{}, ...]

  """
  def list_menu_items do
    Repo.all(MenuItem)
  end

  @doc """
  Gets a single menu_item.

  Raises `Ecto.NoResultsError` if the Menu item does not exist.

  ## Examples

      iex> get_menu_item!(123)
      %MenuItem{}

      iex> get_menu_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_menu_item!(id), do: Repo.get!(MenuItem, id)

  @doc """
  Creates a menu_item.

  ## Examples

      iex> create_menu_item(%{field: value})
      {:ok, %MenuItem{}}

      iex> create_menu_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_menu_item(attrs \\ %{}) do
    %MenuItem{}
    |> MenuItem.changeset(attrs)
    |> Repo.insert()
  end

  def create_menu_items(menu_item_params_list) do
    menu_item_params_list
    |> Enum.map(&create_menu_item/1)
    |> Enum.reduce_while({:ok, []}, fn
      {:ok, menu_item}, {:ok, menu_items} ->
        {:cont, {:ok, [menu_item | menu_items]}}

      {:error, reason}, _ ->
        {:halt, {:error, reason}}
    end)
  end

  @doc """
  Updates a menu_item.

  ## Examples

      iex> update_menu_item(menu_item, %{field: new_value})
      {:ok, %MenuItem{}}

      iex> update_menu_item(menu_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_menu_item(%MenuItem{} = menu_item, attrs) do
    menu_item
    |> MenuItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a menu_item.

  ## Examples

      iex> delete_menu_item(menu_item)
      {:ok, %MenuItem{}}

      iex> delete_menu_item(menu_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_menu_item(%MenuItem{} = menu_item) do
    Repo.delete(menu_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking menu_item changes.

  ## Examples

      iex> change_menu_item(menu_item)
      %Ecto.Changeset{data: %MenuItem{}}

  """
  def change_menu_item(%MenuItem{} = menu_item, attrs \\ %{}) do
    MenuItem.changeset(menu_item, attrs)
  end
end
