defmodule CurrencyConvertion.Users.Transactions do
  @moduledoc """
  Transactions
  """
  alias CurrencyConvertion.ApiLayer.Client
  @base_url Application.compile_env(:currency_convertion, :base_url)

  def exchange(from, to, amount, url \\ @base_url), do: client().call(from, to, amount, url)

  defp client do
    Application.get_env(:currency_convertion, :api_layer_client, Client)
  end
end
