defmodule CurrencyConvertion.Users.Users do
  @moduledoc """
  Provides functions related to User struct
  """
  @moduledoc since: "0.1.0"
  import Ecto.Query
  alias CurrencyConvertion.Repo
  alias CurrencyConvertion.Users.Transaction
  alias CurrencyConvertion.Users.User
  alias Ecto.Changeset

  @doc """
  Fetches an user struct from  the databse.

  ## Parameter
    - user_id: user's id in the database

  ## Examples

      iex> Users.get_user(1)
      {:ok,
      %User{
      __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
      id: 5,
      transactions: [
        %Transaction{
          id: "2e5408db-9fb9-4f0d-8824-9d0f3022f267",
          origin_currency: "BRL",
          origin_amount: Decimal.new("4"),
          destiny_currency: "EUR",
          rate: Decimal.new("0.168739"),
          amount: Decimal.new("0.674956"),
          user_id: 5,
          inserted_at: ~N[2024-07-06 04:12:47],
          updated_at: ~N[2024-07-06 04:12:47]
        }
      ],
      inserted_at: ~N[2024-07-02 05:41:05],
      updated_at: ~N[2024-07-06 04:12:47]
      }}

  """
  @doc since: "0.1.0"

  @spec get_user(integer()) :: {:ok, User.t()} | {:error, :not_found}
  def get_user(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Fetches all user's transactions from  the databse. Returns a list containing transactions or an empty list.

  ## Parameter
    - user_id: user's id in the database

  ## Examples

      iex> Users.transactions(1)
      [
        %Transaction{
          id: "2e5408db-9fb9-4f0d-8824-9d0f3022f267",
          origin_currency: "BRL",
          origin_amount: Decimal.new("4"),
          destiny_currency: "EUR",
          rate: Decimal.new("0.168739"),
          amount: Decimal.new("0.674956"),
          user_id: 5,
          inserted_at: ~N[2024-07-06 04:12:47],
          updated_at: ~N[2024-07-06 04:12:47]
        }
      ]

  """
  @doc since: "0.1.0"

  @spec transactions(integer()) :: list(Transaction.t())
  def transactions(user_id) do
    User
    |> where([u], u.id == ^user_id)
    |> select([u], u.transactions)
    |> Repo.all()
    |> List.flatten()
  end

  @doc """
  Adds a transaction in the database to the user.

  ## Parameters
    - user_id: user's id in the database
    - transaction: a map containing the keys amount, from, rate, result, to

  ## Examples

      iex> Users.add_transaction(1, %{amount: 3, from: "USD", rate: 5.593377, result: 16.780131, to: "BRL"})
      %Transaction{
        id: "4a237d37-56fc-48e4-b01e-aa6623b2ae25",
        origin_currency: "USD",
        origin_amount: 3,
        destiny_currency: "BRL",
        rate: 5.593377,
        amount: 16.780131,
        user_id: 1,
        inserted_at: ~N[2024-07-06 13:46:54],
        updated_at: ~N[2024-07-06 13:46:54]
      }
  """
  @doc since: "0.1.0"
  @spec add_transaction(integer(), Transaction.t()) :: {:ok, User.t()}
  def add_transaction(user_id, transaction) do
    case get_user(user_id) do
      {:error, _} = error -> error
      {:ok, user} -> add(user, transaction)
    end
  end

  defp add(user, transaction) do
    transaction = [
      %Transaction{
        origin_currency: transaction.from,
        origin_amount: transaction.amount,
        destiny_currency: transaction.to,
        rate: transaction.rate,
        amount: transaction.result,
        user_id: user.id
      }
    ]

    Changeset.change(user)
    |> Changeset.put_embed(:transactions, user.transactions ++ transaction)
    |> Repo.update()
    |> then(fn
      {:ok, user} -> List.last(user.transactions)
      {:error, _} = error -> error
    end)
  end
end
