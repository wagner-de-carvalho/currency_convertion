defmodule CurrencyConvertionWeb.TransactionsControllerTest do
  @moduledoc """
  Tests for module transactions_controller
  """
  use CurrencyConvertionWeb.ConnCase, async: true
  import Mox
  alias CurrencyConvertion.ApiLayer.ClientMock
  alias CurrencyConvertion.Factory
  alias CurrencyConvertion.Users.Users

  setup :verify_on_exit!

  describe "list/2" do
    test "lists all user's transactions", %{conn: conn} do
      params = %{amount: 1, from: "USD", rate: 5.593377, result: 5.59337, to: "BRL"}
      user = Factory.insert(:user)
      Users.add_transaction(user.id, params)

      %{"transactions" => transactions} =
        conn
        |> get(~p"/api/users/#{user.id}/transactions")
        |> json_response(:ok)

      assert Enum.count(transactions) == 1
    end

    test "when user does not exist it returns an error", %{conn: conn} do
      response =
        conn
        |> get(~p"/api/users/999/transactions")
        |> json_response(:not_found)

      assert response == %{"error" => "not_found"}
    end
  end

  describe "create/2" do
    test "creates a transaction for a certain user", %{conn: conn} do
      user = Factory.insert(:user)
      params = %{amount: 2, from: "USD", to: "BRL", user_id: user.id}

      expected_response =
        {:ok, %{amount: 2, from: "USD", rate: 5.460204, result: 10.920408, to: "BRL"}}

      ClientMock
      |> expect(:call, fn _, _, _, _ -> expected_response end)

      response =
        conn
        |> post(~p"/api/users/transactions", params)
        |> json_response(:created)

      assert %{
               "date_time" => _,
               "destiny_currency" => "BRL",
               "origin_amount" => 2,
               "origin_currency" => "USD",
               "rate" => _,
               "transaction_id" => _,
               "user_id" => _
             } = response
    end

    test "when user does not exist it returns an error", %{conn: conn} do
      params = %{amount: 2, from: "USD", to: "BRL", user_id: 999}

      response =
        conn
        |> post(~p"/api/users/transactions", params)
        |> json_response(:not_found)

      assert response == %{"error" => "not_found"}
    end
  end
end
