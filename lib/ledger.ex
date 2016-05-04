defmodule Ledger do
  use Application

  def start(_type, _args) do
    IO.puts "Ledger#start"
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Ledger.Web,  [], function: :run),
      supervisor(Ledger.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Ledger.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
