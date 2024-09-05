defmodule RestaurantPlatform.OrdersTest do
  use RestaurantPlatform.DataCase

  alias RestaurantPlatform.Orders

  describe "orders" do
    alias RestaurantPlatform.Orders.Order

    import RestaurantPlatform.OrdersFixtures

    @invalid_attrs %{ordered_at: nil, payed_at: nil, total_amount: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{ordered_at: ~U[2024-08-27 07:29:00Z], payed_at: ~U[2024-08-27 07:29:00Z], total_amount: "120.5"}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.ordered_at == ~U[2024-08-27 07:29:00Z]
      assert order.payed_at == ~U[2024-08-27 07:29:00Z]
      assert order.total_amount == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{ordered_at: ~U[2024-08-28 07:29:00Z], payed_at: ~U[2024-08-28 07:29:00Z], total_amount: "456.7"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.ordered_at == ~U[2024-08-28 07:29:00Z]
      assert order.payed_at == ~U[2024-08-28 07:29:00Z]
      assert order.total_amount == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
