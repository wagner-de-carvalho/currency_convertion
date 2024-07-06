defmodule CurrencyConvertionWeb.TransactionsController do
  @moduledoc """
  Transactions controller
  """
  use CurrencyConvertionWeb, :controller
  use PhoenixSwagger
  alias CurrencyConvertion.Users.Transaction
  alias CurrencyConvertion.Users.Transactions
  alias CurrencyConvertion.Users.Users
  alias CurrencyConvertionWeb.FallbackController

  @base_url Application.compile_env(:currency_convertion, :base_url)

  action_fallback FallbackController

  def swagger_definitions do
    %{
      Transaction:
        swagger_schema do
          title("Transaction")
          description("Exchange transaction")

          properties do
            destiny_currency(:string, "To")
            origin_amount(:string, "Amount")
            origin_currency(:string, "From")
            rate(:number, "Transaction rate")
            transaction_id(:string, "Transaction id")
            date_time(:string, "Transaction timestamp", format: :datetime)
            user_id(:integer, "User id")
          end
        end,
      TransactionResponse:
        swagger_schema do
          title("TransactionResponse")
          description("Response schema for single transaction")
          property(:data, Schema.ref(:Transaction), "The transaction details")
        end,
      TransactionsResponse:
        swagger_schema do
          title("TransactionsResponse")
          description("Response schema for transactions array")
          property(:data, Schema.array(:Transaction), "The user's transactions details")
        end,
      TransactionRequest:
        swagger_schema do
          title("TransactionRequest")
          description("Request to create a transaction")

          properties do
            to(:string, "Destiny currency", required: true)
            amount(:integer, "Amount", required: true)
            from(:string, "Origin currency", required: true)
            user_id(:integer, "User id", required: true)
          end
        end
    }
  end

  swagger_path(:create) do
    post("/transactions")
    summary("Create a new transaction")
    description("Adds transaction to an user")
    consumes("application/json")
    produces("application/json")

    parameter(:transaction, :body, Schema.ref(:TransactionRequest), "The transaction details",
      example: %{
        transaction: %{user_id: 1, from: "BRL", to: "USD", amount: 3}
      }
    )

    response(201, "Transaction created OK", Schema.ref(:TransactionResponse),
      example: %{
        data: %{
          user_id: 1,
          transaction_id: "7da853f7-c6ee-464b-85b6-b39fda6e8110",
          destiny_currency: "USD",
          origin_currency: "BRL",
          rate: 5.47542,
          date_time: "2024-07-06T12:36:00"
        }
      }
    )

    response(404, "User not found", %{error: :not_found})

    response(400, "Invalid amount", %{
      error: %{
        error: %{
          code: "invalid_conversion_amount",
          message: "You have not specified an amount to be converted. [Example: amount=5]"
        }
      }
    })
  end

  def create(conn, params) do
    url = Map.get(params, "url", @base_url)

    with {:ok, data} <-
           Transactions.exchange(params["from"], params["to"], params["amount"], url),
         %Transaction{} = transaction <- Users.add_transaction(params["user_id"], data) do
      conn
      |> put_status(:created)
      |> render(:create, transaction: transaction)
    end
  end

  swagger_path(:list) do
    get("/{user_id}/transactions")
    summary("List transactions")
    description("List all user's transactions in the database")
    produces("application/json")
    parameter(:user_id, :path, :integer, "User ID", required: true, example: 1)

    response(200, "OK", Schema.ref(:TransactionsResponse),
      example: %{
        data: [
          %{
            date_time: "2024-07-06T05:14:35",
            destiny_currency: "BRL",
            origin_amount: 2,
            origin_currency: "EUR",
            rate: 5.926306,
            transaction_id: "6fdee579-a151-4135-8d01-1db1ba14613c",
            user_id: 1
          },
          %{
            date_time: "2024-07-06T05:20:22",
            destiny_currency: "BRL",
            origin_amount: 3,
            origin_currency: "USD",
            rate: 5.460204,
            transaction_id: "a7f57243-11f5-4e3a-bdcc-91ab1e6b7e14",
            user_id: 1
          }
        ]
      }
    )

    response(404, "not_found", %{error: :not_found})
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
