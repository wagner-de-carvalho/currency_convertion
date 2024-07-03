defmodule CurrencyConvertionWeb.FallbackController do
  @moduledoc """
  Falls back to this module when user_controller returns errors
  """
  use CurrencyConvertionWeb, :controller
  alias CurrencyConvertionWeb.ErrorJSON
  alias Ecto.Changeset

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, error: :not_found)
  end
end