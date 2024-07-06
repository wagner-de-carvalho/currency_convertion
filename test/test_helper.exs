Mox.defmock(CurrencyConvertion.ApiLayer.ClientMock,
  for: CurrencyConvertion.ApiLayer.ClientBehaviour
)

Application.put_env(
  :currency_convertion,
  :api_layer_client,
  CurrencyConvertion.ApiLayer.ClientMock
)

{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(CurrencyConvertion.Repo, :manual)
