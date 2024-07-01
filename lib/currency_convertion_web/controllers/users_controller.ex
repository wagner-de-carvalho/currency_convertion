defmodule CurrencyConvertionWeb.UsersController do
  @moduledoc """
  User controller
  """
  use CurrencyConvertionWeb, :controller
  alias CurrencyConvertion.ApiLayer.Client
  alias CurrencyConvertionWeb.FallbackController
  alias CurrencyConvertion.Users.Transaction
  alias CurrencyConvertion.Users.Users

  #   %CurrencyConvertion.Users.Transaction{
  #   id: "5f0dae81-3908-45b8-b943-60a0bc2ff148",
  #   origin_currency: "USD",
  #   origin_amount: 3,
  #   destiny_currency: "BRL",
  #   rate: 5.593377,
  #   amount: 16.780131,
  #   user_id: 1,
  #   inserted_at: ~N[2024-07-01 03:07:23],
  #   updated_at: ~N[2024-07-01 03:07:23]
  # }

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
