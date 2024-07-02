defmodule CurrencyConvertion.Users.UsersTest do
  @moduledoc """
  Tests for module users
  """
  use CurrencyConvertion.DataCase, async: true
  use ExMachina.Ecto, repo: CurrencyConvertion.Repo
  alias CurrencyConvertion.Factory
  alias CurrencyConvertion.Users.Transaction
  alias CurrencyConvertion.Users.User
  alias CurrencyConvertion.Users.Users

  describe "get_user/1" do
    test "when user_id exists it returns an user" do
      user = Factory.insert(:user)
      {:ok, response} = Users.get_user(user.id)
      assert %User{} = user
      assert user.id == response.id
    end

    test "when user_id does not exist it returns an error" do
      response = Users.get_user(1)
      assert {:error, :not_found} == response
    end
  end

  describe "add_transaction/2" do
    test "when params are correct it adds a new transaction" do
      transaction = %{amount: 1, from: "USD", rate: 5.593377, result: 5.59337, to: "BRL"}
      user = Factory.insert(:user)
      response = Users.add_transaction(user.id, transaction)
      assert %Transaction{} = response
      assert transaction.from == "USD"
      assert transaction.to == "BRL"
      assert transaction.amount == 1
    end

    test "when user_id does not exist it returns an error" do
      response = Users.add_transaction(10, %{})
      assert response == {:error, :not_found}
    end
  end

  describe "transactions/1" do
    test "when user_id exists it lists user transactions" do
      transaction = %{amount: 3, from: "USD", rate: 5.593377, result: 16.780131, to: "BRL"}
      user = Factory.insert(:user)
      Users.add_transaction(user.id, transaction)

      {:ok, updated_user} = Users.get_user(user.id)
      transactions = Users.transactions(updated_user.id)

      assert transactions |> Enum.count() == 1
    end

    test "when user_id does not exist it returns an empty list" do
      transactions = Users.transactions(10)
      assert transactions == []
    end
  end
end
