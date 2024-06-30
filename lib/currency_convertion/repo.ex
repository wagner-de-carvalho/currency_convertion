defmodule CurrencyConvertion.Repo do
  use Ecto.Repo,
    otp_app: :currency_convertion,
    adapter: Ecto.Adapters.Postgres
end
