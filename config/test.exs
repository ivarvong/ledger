use Mix.Config

config :ledger, Ledger.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "ecto://ivar:@localhost/ledger_test"
