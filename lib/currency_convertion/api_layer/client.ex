defmodule CurrencyConvertion.ApiLayer.Client do
  @moduledoc """
  Requests to APILayer currency exchange API
  """
  use Tesla
  alias Tesla.Env

  @base_url Application.compile_env(:currency_convertion, :base_url)
  @currency_api_key Application.compile_env(:currency_convertion, :exchange_api_key)

  plug(Tesla.Middleware.Headers, [{"apikey", @currency_api_key}])
  plug(Tesla.Middleware.JSON)

  @spec call(String.t(), String.t(), integer()) :: {:ok, map()} | {:error, map()}
  def call(from, to, amount \\ 1)

  def call(from, to, amount) do
    IO.inspect(from, label: "CALL FROM >> ")

    "#{@base_url}?to=#{to}&from=#{from}&amount=#{amount}"
    |> get()
    |> handle_call()
    |> IO.inspect(label: "HANDLE >> ")
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
end
