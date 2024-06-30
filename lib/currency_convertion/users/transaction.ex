defmodule CurrencyConvertion.Users.Transaction do
  @moduledoc """
  Embedded fields to User struct
  """
  use Ecto.Schema

  embedded_schema do
    field(:origin_currency, :string)
    field(:origin_amount, :decimal)
    field(:destiny_currency, :string)
    field(:rate, :decimal)
    field(:amount, :decimal)
    field(:user_id, :integer)
    timestamps()
  end
end
