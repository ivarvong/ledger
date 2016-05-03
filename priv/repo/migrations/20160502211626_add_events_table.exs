defmodule Ledger.Repo.Migrations.AddEventsTable do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :device, :string
      add :ip,     :string
      add :type,   :string
      add :key,    :string
      add :data,   :map

      timestamps
    end
  end
end
