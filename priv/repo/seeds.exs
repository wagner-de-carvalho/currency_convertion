# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CurrencyConvertion.Repo.insert!(%CurrencyConvertion.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias CurrencyConvertion.Repo
alias CurrencyConvertion.Users.User

Enum.map(1..5, fn _ -> Repo.insert(%User{}) end)
