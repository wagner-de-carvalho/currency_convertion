defmodule CurrencyConvertionWeb.TransactionsController do
  @moduledoc """
  Transactions controller
  """
  use CurrencyConvertionWeb, :controller
  alias CurrencyConvertion.ApiLayer.Client
  alias CurrencyConvertion.Users.Transaction
  alias CurrencyConvertion.Users.Users
  alias CurrencyConvertionWeb.FallbackController

  @base_url Application.compile_env(:currency_convertion, :base_url)

  action_fallback FallbackController

  def create(conn, params) do
    url = Map.get(params, "url", @base_url)

    with {:ok, data} <-
           client().call(params["from"], params["to"], params["amount"], url),
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

  defp client do
    Application.get_env(:currency_convertion, :api_layer_client, Client)
  end
end
