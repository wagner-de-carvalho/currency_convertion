defmodule CurrencyConvertion.Users.User do
  @moduledoc """
  User struct maps the users table on database
  """
  @moduledoc since: "0.1.0"
  use Ecto.Schema

  alias CurrencyConvertion.Users.Transaction

  schema "users" do
    embeds_many(:transactions, Transaction)
    timestamps()
  end
end
