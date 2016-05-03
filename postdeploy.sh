#!/bin/bash
set -e
mix do deps.get, compile
mix ecto.create -r Repo
mix ecto.migrate -r Repo
