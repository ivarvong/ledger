use Mix.Config

config :ledger, Ledger.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, DATABASE_URL}
