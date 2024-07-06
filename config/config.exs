# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :currency_convertion,
  ecto_repos: [CurrencyConvertion.Repo]

# Configures the endpoint
config :currency_convertion, CurrencyConvertionWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: CurrencyConvertionWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: CurrencyConvertion.PubSub,
  live_view: [signing_salt: "Q75XUwYa"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# swagger config.exs
config :currency_convertion, CurrencyConvertionWeb.Endpoint, url: [host: "localhost"]
# "host": "localhost:4000" in generated swagger

# swagger
config :currency_convertion, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      # phoenix routes will be converted to swagger paths
      router: CurrencyConvertionWeb.Router
    ]
  }

# swaager Jason
config :phoenix_swagger, json_library: Jason

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :currency_convertion,
  exchange_api_key: System.fetch_env!("EXCHANGE_API_KEY"),
  base_url: "https://api.apilayer.com/exchangerates_data/convert"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
