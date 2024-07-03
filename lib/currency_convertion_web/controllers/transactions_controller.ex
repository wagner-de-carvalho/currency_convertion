defmodule CurrencyConvertionWeb.TransactionsController do
  @moduledoc """
  Transactions controller
  """
  use CurrencyConvertionWeb, :controller
  alias CurrencyConvertion.ApiLayer.Client
  alias CurrencyConvertionWeb.FallbackController
  alias CurrencyConvertion.Users.Transaction
  alias CurrencyConvertion.Users.Users

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, data} <- Client.call(params["from"], params["to"], params["amount"]),
         %Transaction{} = transaction <- Users.add_transaction(params["user_id"], data) do
      conn
      |> put_status(:created)
      |> render(:create, transaction: transaction)
    end
  end

  def list(conn, %{"user_id" => user_id}) do
    with {:ok, _user} <- Users.get_user(user_id) do
      transactions = Users.transactions(user_id)

      conn
      |> put_status(:ok)
      |> render(:list, transactions: transactions)
    end
  end
end
