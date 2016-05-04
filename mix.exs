defmodule Ledger.Mixfile do
  use Mix.Project

  def project do
    [app: :ledger,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:cowboy, :plug, :postgrex, :ecto, :logger],
     mod: {Ledger, []}]
  end

  defp deps do
    [{:postgrex, ">= 0.0.0"},
     {:ecto, "== 2.0.0-beta.2"},
     {:poison, "~> 2.0"},
     {:cowboy, "~> 1.0.0"},
     {:plug, "~> 0.12"},]
  end
end
