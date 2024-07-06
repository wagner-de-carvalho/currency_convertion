defmodule CurrencyConvertionWeb.Router do
  use CurrencyConvertionWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :exists_user_id do
    plug CurrencyConvertionWeb.Plugs.CheckUserId
  end

  scope "/api", CurrencyConvertionWeb do
    pipe_through [:api, :exists_user_id]

    get("/users/:user_id/transactions", TransactionsController, :list)
    post("/users/transactions", TransactionsController, :create)
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :currency_convertion,
      swagger_file: "swagger.json"
  end

  # Swagger
  def swagger_info do
    %{
      basePath: "/api/users",
      info: %{
        version: "0.1.0",
        title: "Currency Convertion"
      },
      tags: [
      ]
    }
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:currency_convertion, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: CurrencyConvertionWeb.Telemetry
    end
  end
end
