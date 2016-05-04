defmodule LedgerTest do
  import Ecto.Query

  use ExUnit.Case
  use Plug.Test

  doctest Ledger

  alias Ledger.Router, as: Router;
  alias Ledger.Event, as: Event;
  alias Ledger.Repo, as: Repo;

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "can insert events directly" do
    expected_count = 10

    for _ <- 1..expected_count, do:
      Repo.insert!(%Event{
        type: "test",
        key: "test",
        device: "d_#{random_string(10)}",
        ip: random_string(5),
        data: %{
          key1: random_string(10),
          key2: random_string(10),
        },
      })

    count = Event
      |> where(type: "test")
      |> Repo.all
      |> Enum.count

    assert(count == expected_count)
  end

  test "can get /status" do
    conn = conn(:get, "/status")
    response = Router.call(conn, [])
    assert response.status == 200
    assert response.resp_body == "OK"
  end

  test "can insert events via HTTP GET request" do
    expected_count = 10

    user_agent = "UA_#{random_string(20)}"
    json = Poison.encode!(%{
      user_agent: user_agent
    })

    for _ <- 1..expected_count, do:
      Router.call(conn(:get, "/v1/event?json=#{json}"), [])


    # check the DB has the event
    event_count = Event
      |> Repo.all
      |> Enum.map(fn evt -> evt.data end)
      |> Enum.filter(fn data -> data["user_agent"] == user_agent end)
      |> Enum.count
    assert event_count == expected_count
  end

end
