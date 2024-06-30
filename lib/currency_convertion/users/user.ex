defmodule CurrencyConvertion.Users.User do
  @moduledoc """
  User struct maps the users table on database
  """
  use Ecto.Schema

  alias CurrencyConvertion.Users.Transaction

  schema "users" do
    embeds_many(:transactions, Transaction)
    timestamps()
  end
end
