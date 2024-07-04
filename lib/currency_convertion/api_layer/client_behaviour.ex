defmodule CurrencyConvertion.ApiLayer.ClientBehaviour do
  @moduledoc """
  Behaviour for client API
  """
  @callback call(String.t(), String.t(), integer(), String.t()) :: {:ok, map()} | {:error, map()}
end
