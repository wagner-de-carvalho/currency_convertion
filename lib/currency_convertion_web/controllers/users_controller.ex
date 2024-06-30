defmodule CurrencyConvertionWeb.UsersController do
  @moduledoc """
  User controller
  """
  use CurrencyConvertionWeb, :controller
  alias CurrencyConvertionWeb.FallbackController
  alias CurrencyConvertion.Users.Users

  action_fallback FallbackController

  def transactions(conn, %{"user_id" => user_id}) do
    with {:ok, _user} <- Users.get_user(user_id) do
      transactions = Users.transactions(user_id)

      conn
      |> put_status(:ok)
      |> render(:list, transactions: transactions)
    end
  end
end
