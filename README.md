# CurrencyConvertion

![Continuous Integration](https://github.com/wagner-de-carvalho/currency_convertion/actions/workflows/lint.yml/badge.svg) ![Continuous Integration](https://github.com/wagner-de-carvalho/currency_convertion/actions/workflows/tests.yml/badge.svg) ![Continuous Integration](https://github.com/wagner-de-carvalho/currency_convertion/actions/workflows/cd.yml/badge.svg)

 **CurrencyConvertion** is an API that queries currency exchange, adds transactions related to users, lists transactions executed by users.

## Purpose

The purpose of this API is to present a solution that meets the requirements proposed by the customer. These requirements are: 
- a currency converter that must exchange at least 4 currencies;
- store transactions carried out by users in the database;
- list user transactions;
- create tests for these functionalities, according to the problem description.

## Features

In this project we will not provide an API to **create users**, since the purpose of this API is to exchange currencies. We will use a ***seed file***, which will create some users locally. For the project deployed on Gigalixir (Platform as a Service), we already have **four users inserted** whose ID's are ranging from 1 to 4.

**Main features**:

- List user's transactions - it returns a list containing all transactions performed by a certain user.
- Add a new transaction to user's transactions = adds a new transaction to a certain user.
- Get user - fetches a user, based on it's ID.
- APILayer client = query external currency API to obtain conversion rates and amount values.

## Motivation for the main technology

The main reason for choosing the main technologies for this project is to comply with the customer requirements, so that the skills using these technologies are evaluated by the company.
Another motivation is the fact that this programmer has already had knowledge of these technologies for some time.

## Technologies used in this project

- [Ecto](https://hexdocs.pm/ecto/3.10.3/Ecto.html) - Ecto is a toolkit for data mapping and language integrated query for Elixir.
- [Elixir](https://hexdocs.pm/elixir/1.14.2/Kernel.html) - Elixir is a dynamic, functional language for building scalable and maintainable applications.
- [Phoenix framework](https://hexdocs.pm/phoenix/1.7.7/overview.html) - Phoenix is a web framework for the Elixir programming language.
- [Postgres](https://www.postgresql.org/docs/current/) - PostgreSQL is a powerful, open source object-relational database system.

## Libraries

- [Bypass documentation](https://hexdocs.pm/bypass/Bypass.html) - a quick way to create a custom plug that can be put in place instead of an actual HTTP server to return prebaked responses to client requests.
- [ExMachina documentation](https://hexdocs.pm/ex_machina/index.html) - ExMachina makes it easy to create test data and associations.
- [Mox documentation](https://hexdocs.pm/mox/Mox.html) - Mox is a library for defining concurrent mocks in Elixir.
- [Tesla documentation](https://hexdocs.pm/tesla/readme.html) - Flexible HTTP client library for Elixir.

### External API

In this project we are using the `Exchange Rates Data` API to delivering exchanging rates data for more than 170 world currencies.

**API documentation**

- [APILayer documentation](https://apilayer.com/marketplace/exchangerates_data-api#endpoints) - APILayer

## Separation of layers

- Domain layer - this is the core of the application, where user and transaction entities are defined as well as the repository.
- Application layer - in this layer we have the main features of the application, such as list transactions, query user, add new transaction.
- Presentation layer - this is the layer where we have controllers and views, responsible for receiving requests and displaying relevant data to the user.

## Start the project locally

To run this project **locally**, you must have **postgres** database installed (or docker) and running, **Elixir 1.14** and **Phoenix 1.7** framework.
Take the following steps to start the project on **local environment**:

```elixir
# Configure your database
# config/dev.exs add your credentials (username, password, database)
config :currency_convertion, CurrencyConvertion.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "currency_convertion_dev",
```
-  You must have **APILayer Exchange Rates Data API** token. Export it as:
```shell
export EXCHANGE_API_KEY=your-api-key
``` 
If you do not have one, you can create an account on [APILayer](https://apilayer.com) for free.

```shell
git clone https://github.com/wagner-de-carvalho/currency_convertion.git
mix deps.get
export EXCHANGE_API_KEY=your-api-key
mix ecto.setup
mix phx.swagger.generate
iex -S mix phx.server
```

## Swagger UI - API Documentation

Use swagger API documentation to run tests locally:
- `http://localhost:4000/api/swagger/index.html`


## Gigalixir - project running remotely

Gigalixir is a Platform as a Service designed by and for Elixir developers.
The application was ***deployed*** and is currently running remotely at **Gigalixir** on `https://currency-convertion.gigalixirapp.com/`.
In order to make HTTP requests, change your **localhost:4000** environment to remote environment:

```shell
curl https://currency-convertion.gigalixirapp.com/api/users/1/transactions
```
We already have **four users inserted** whose ID's are ranging from 1 to 4.

