# CurrencyConvertion
 **CurrencyConvertion** is an API that queries currency exchange, adds transactions related to users, lists transactions executed by users.

## Purpose
The purpose of this API is to present a solution that meets the requirements proposed by the customer. These requirements are: 
- a currency converter that must exchange at least 4 currencies;
- store transactions carried out by users in the database;
- list user transactions;
- create tests for these functionalities, according to the problem description.

## Features
In this project we will not provide an API to **create users**, since the purpose of this API is to exchange currencies. We will use a ***seed file***, which will create some users.
**Main features**:
- List user's transactions = it returns a list containing all transactions performed by a certain user.
- Add a new transaction user's transactions = adds a new transaction to a certain user.
- Get user = fetches a user, based on it's id.
- APILayer client = query external currency API to obtain conversion rates and amount values.

## Motivation for the main technology
The main reason for choosing the main technologies for this project is to comply with the customer requirements, so that the skills using these technologies are evaluated by the company.
Another motivation is the fact that this programmer has already had knowledge of these technologies for some time.

### Technologies used in this project
- `Elixir` = programming language;
- `Phoenix` framework = Phoenix is a web framework for the Elixir programming language;
- Ecto = Ecto is a toolkit for data mapping and language integrated query for Elixir;
- `Postgres` = is a powerful, open source object-relational database.

### Libraries
- tesla = Tesla is an HTTP client loosely based on Faraday. It embraces the concept of middleware when processing the request/response cycle.
- ex_machina = ExMachina makes it easy to create test data and associations.
- bypass = Bypass is an OTP application that masquerades as an external server listening for and responding to requests. 

## Separation of layers
- Domain layer = this is the core of the application, where user and transaction entities are defined as well as the repository.
- Application layer = in this layer we have the main features of the application, such as list transactions, query user, add new transaction.
- Presentation layer = this is the layer where we have controllers and views, responsible for receiving requests and displaying relevant data to the user.

## Start the project
To run this project, you must have postgres database installed and running, Elixir and Phoenix framework.
Take the following steps to start the project on **local environment**:
1 - Clone the project: `git clone https://github.com/wagner-de-carvalho/currency_convertion.git`
2 - Donwnload the dependencies: `mix deps.get`
3 - In **config/dev.exs** add your credentials (username, password, database) to the database;
4 - You must have APILayer Exchange Rates Data API token. Export it as `export EXCHANGE_API_KEY=your-api-key`. If you do not have one, you can create an account on `https://apilayer.com` for free;
5 - Create the database: `mix ecto.setup` or `mix ecto.create, mix ecto.migrate`;
6 - Run the **seeds** file to create users: `mix run priv/repo/seeds.exs`;
7 - Start the application: `iex -S mix phx.server`.