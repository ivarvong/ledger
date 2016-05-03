use Mix.Config

config :ledger, Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "ecto://ivar:@localhost/ledger_development"
