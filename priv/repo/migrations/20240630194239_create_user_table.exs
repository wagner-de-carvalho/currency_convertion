defmodule CurrencyConvertion.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table("users") do
      timestamps()
    end
  end
end
