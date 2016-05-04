ExUnit.start()

# Mix.Task.run "ecto.drop", ["-r", "Repo"]
Mix.Task.run "ecto.create"
Mix.Task.run "ecto.migrate"

Ledger.Event |> Ledger.Repo.delete_all
