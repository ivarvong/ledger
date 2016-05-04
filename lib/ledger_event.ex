defmodule Ledger.Event do
  use Ecto.Schema

  schema "events" do
    field :device, :string
    field :ip, :string
    field :type, :string
    field :key, :string
    field :data, :map

    timestamps
  end

end
