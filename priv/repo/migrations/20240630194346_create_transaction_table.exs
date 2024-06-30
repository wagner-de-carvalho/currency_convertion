defmodule CurrencyConvertion.Repo.Migrations.CreateTransactionTable do
  use Ecto.Migration

  def change do
    alter table("users") do
      add(:transactions, {:array, :map})
    end
  end
end
