# CurrencyConvertion
 **CurrencyConvertion** is an API that queries currency exchange, adds transactions related to users, lists transactions executed by users.

## Purpose
The purpose of this API is to present a solution that meets the requirements proposed by the customer. These requirements are: 
- a currency converter that must exchange at least 4 currencies;
- store transactions carried out by users in the database;
- list user transactions;
- create tests for these functionalities, according to the problem description.

## Features
- Lists user's transactions = it returns a list containing all transactions performed by a certain user.
- Add a new transaction user's transactions = adds a new transaction to a certain user.
- Get user = fetches a user, based on it's id.
- APILayer client = query external currency API to obtain conversion rates and amount values.

## Motivation for the main technology
The main reason for choosing the main technologies for this project is to comply with the customer requirements, so that the skills using these technologies are evaluated by the company.
Another motivation is the fact that this programmer has already had knowledge of these technologies for some time.

### Technologies used in this project
- Elixir = programming language;
- Phoenix framework = Phoenix is a web framework for the Elixir programming language;
- Ecto = Ecto is a toolkit for data mapping and language integrated query for Elixir;
- Postgres =  is a powerful, open source object-relational database.

### Libraries
- tesla = Tesla is an HTTP client loosely based on Faraday. It embraces the concept of middleware when processing the request/response cycle.
- ex_machina = ExMachina makes it easy to create test data and associations.
- bypass = Bypass is an OTP application that masquerades as an external server listening for and responding to requests. 

## Separation of layers
- Domain layer = this is the core of the application, where user and transaction entities are defined as well as the repository.
- Application layer = in this layer we have the main features of the application, such as list transactions, query user, add new transaction.
- Presentation layer = this is the layer where we have controllers and views, responsible for receiving requests and displaying relevant data to the user.