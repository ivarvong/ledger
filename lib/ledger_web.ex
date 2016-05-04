defmodule Ledger.Web do
  use Application

  def start(_typs, _args) do
    IO.puts "LedgerWeb#start"
    import Supervisor.Spec
  end

  def run do
    IO.puts "LedgerWeb#run"

    # TODO: refactor
    opts = [port: 4000, compress: true]
    if port = System.get_env("PORT") do
      opts = Keyword.put(opts, :port, String.to_integer(port))
    end

    {:ok, _} = Plug.Adapters.Cowboy.http(Ledger.Router, [], opts)
  end

end
