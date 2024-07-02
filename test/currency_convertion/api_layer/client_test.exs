defmodule CurrencyConvertion.ApiLayer.ClientTest do
  @moduledoc """
  Tests for external API APILayer
  """
  use ExUnit.Case, aync: true
  alias CurrencyConvertion.ApiLayer.Client

  @base_url "http://localhost"

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns currency info", %{bypass: bypass} do
      from = "USD"
      amount = 3
      to = "BRL"

      body =
        Jason.encode!(%{
          "date" => "2024-07-01",
          "info" => %{"rate" => 0.176788, "timestamp" => 1_719_874_564},
          "query" => %{"amount" => 3, "from" => "BRL", "to" => "USD"},
          "result" => 0.530364,
          "success" => true
        })

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      expected_response =
        {:ok,
         %{
           amount: 3,
           from: "BRL",
           rate: 0.176788,
           result: 0.530364,
           to: "USD"
         }}

      url = endpoint_url(bypass.port)
      response = Client.call(from, to, amount, url)

      assert response == expected_response
    end

    test "when any param is incorrect it returns an error", %{bypass: bypass} do
      from = "XYZ"
      amount = 3
      to = "BRL"

      body =
        Jason.encode!(%{
          "error" => %{
            "code" => "invalid_from_currency",
            "message" => "You have entered an invalid \"from\" property. [Example: from=EUR]"
          }
        })

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(400, body)
      end)

      expected_response =
        {:error,
         %{
           "error" => %{
             "code" => "invalid_from_currency",
             "message" => "You have entered an invalid \"from\" property. [Example: from=EUR]"
           }
         }}

      url = endpoint_url(bypass.port)
      response = Client.call(from, to, amount, url)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "#{@base_url}:#{port}"
end
