ExUnit.start()

# Mix.Task.run "ecto.drop", ["-r", "Repo"]
Mix.Task.run "ecto.create", ["-r", "Repo"]
Mix.Task.run "ecto.migrate", ["-r", "Repo"]
