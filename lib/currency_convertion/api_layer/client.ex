defmodule CurrencyConvertion.ApiLayer.Client do
  @moduledoc """
  Requests to APILayer currency exchange API
  """
  use Tesla
  alias CurrencyConvertion.ApiLayer.ClientBehaviour
  alias Tesla.Env

  @currency_api_key Application.compile_env(:currency_convertion, :exchange_api_key)

  plug(Tesla.Middleware.Headers, [{"apikey", @currency_api_key}])
  plug(Tesla.Middleware.JSON)

  @behaviour ClientBehaviour

  @impl ClientBehaviour
  def call(from, to, amount, url) do
    "#{url}?to=#{to}&from=#{from}&amount=#{amount}"
    |> get()
    |> handle_call()
  end

  defp handle_call({:ok, %Env{body: body, status: 200}}) do
    %{"info" => info, "query" => query, "result" => result} = body

    {:ok,
     %{
       result: result,
       rate: info["rate"],
       amount: query["amount"],
       from: query["from"],
       to: query["to"]
     }}
  end

  defp handle_call({:ok, %Env{body: body, status: _}}), do: {:error, body}
  defp handle_call(error), do: {:error, error}
end
