defmodule CurrencyConvertion.Factory do
  @moduledoc """
  Factory for user
  """
  use ExMachina.Ecto, repo: CurrencyConvertion.Repo
  alias CurrencyConvertion.Users.User

  def user_factory do
    %User{
      transactions: []
    }
  end
end
