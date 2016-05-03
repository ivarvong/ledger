defmodule LedgerTest do
  import Ecto.Query
  use ExUnit.Case
  doctest Ledger

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "can insert events" do
    Event |> where(type: "test") |> Repo.delete_all
    expected_count = 100


    for _ <- 1..expected_count, do:
      Repo.insert!(%Event{
        type: "test",
        key: "test",
        device: "d_#{random_string(10)}",
        ip: random_string(5),
        data: %{ key1: random_string(10), key2: random_string(10) },
      })

    count = Event
      |> where(type: "test")
      |> Repo.all
      |> Enum.count

    assert(count == expected_count)
  end

end
