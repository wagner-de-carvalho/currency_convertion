defmodule CurrencyConvertion.Users.Users do
  @moduledoc """
  Users module contains functions related to User struct
  """
  import Ecto.Query
  alias CurrencyConvertion.Repo
  alias CurrencyConvertion.Users.Transaction
  alias CurrencyConvertion.Users.User
  alias Ecto.Changeset

  @spec get_user(integer()) :: {:ok, User.t()} | {:error, :not_found}
  def get_user(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @spec transactions(integer()) :: list(Transaction.t())
  def transactions(user_id) do
    User
    |> where([u], u.id == ^user_id)
    |> select([u], u.transactions)
    |> Repo.all()
    |> List.flatten()
  end

  @spec add_transaction(integer(), Transaction.t()) :: {:ok, User.t()}
  def add_transaction(user_id, transaction) do
    case get_user(user_id) do
      {:error, _} = error -> error
      {:ok, user} -> add(user, transaction)
    end
  end

  defp add(user, transaction) do
    transactions =
      user.transactions ++
        [
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
    |> Changeset.put_embed(:transactions, transactions)
    |> Repo.update()
  end
end
