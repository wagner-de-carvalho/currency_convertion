defmodule CurrencyConvertionWeb.UsersJSON do
  @moduledoc """
  View for user struct
  """
  alias CurrencyConvertion.Users.Transaction

  def list(%{transactions: transactions}) do
    %{transactions: data(transactions)}
  end

  defp data(%Transaction{} = transaction) do
    %{
      user_id: transaction.user_id,
      origin_currency: transaction.origin_currency,
      origin_amount: transaction.origin_amount,
      destiny_currency: transaction.destiny_currency,
      rate: transaction.rate,
      date_time: transaction.inserted_at
    }
  end

  defp data(transactions) when is_list(transactions) do
    Enum.map(transactions, &data/1)
  end
end
