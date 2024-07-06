defmodule CurrencyConvertion.Users.Transactions do
  @moduledoc """
  Provides interface with currency API client
  """
  @moduledoc since: "0.1.0"

  alias CurrencyConvertion.ApiLayer.Client
  @base_url Application.compile_env(:currency_convertion, :base_url)

  @doc """
  Fetches exchange rate data from external currency API.

  ## Parameters
    - from: origin currency
    - to: destiny currency
    - amount: amount to exchange
    - url: optional url for localhost server or remote

  ## Examples

      iex> Transactions.exchange("BRL", "USD", 1, "http://host")
      {:ok, %{amount: 1, from: "BRL", rate: 0.182634, result: 0.182634, to: "USD"}}

  """
  @doc since: "0.1.0"
  @spec exchange(String.t(), String.t(), integer(), String.t()) :: {:ok, map()} | {:error, map()}
  def exchange(from, to, amount, url \\ @base_url), do: client().call(from, to, amount, url)

  defp client do
    Application.get_env(:currency_convertion, :api_layer_client, Client)
  end
end
