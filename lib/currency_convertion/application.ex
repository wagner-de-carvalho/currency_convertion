defmodule CurrencyConvertion.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CurrencyConvertionWeb.Telemetry,
      # Start the Ecto repository
      CurrencyConvertion.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CurrencyConvertion.PubSub},
      # Start the Endpoint (http/https)
      CurrencyConvertionWeb.Endpoint
      # Start a worker by calling: CurrencyConvertion.Worker.start_link(arg)
      # {CurrencyConvertion.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CurrencyConvertion.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CurrencyConvertionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
