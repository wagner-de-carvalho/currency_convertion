defmodule CurrencyConvertionWeb.Plugs.CheckUserId do
  @moduledoc """
  Plug to verify if user id is present in connection
  """
  import Plug.Conn
  alias CurrencyConvertion.Users.Users
  alias Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    with %{"user_id" => id} <- conn.params,
         {:ok, _user} <- Users.get_user(id) do
      conn
    else
      _ ->
        conn
        |> put_status(:not_found)
        |> Controller.put_view(json: CurrencyConvertionWeb.ErrorJSON)
        |> Controller.render(:error, error: :not_found)
        |> halt()
    end
  end
end
