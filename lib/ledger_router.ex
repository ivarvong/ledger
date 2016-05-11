defmodule Ledger.Router do
  use Plug.Router

  plug Plug.Logger
  plug Plug.Head
  plug Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison
  plug Plug.RequestId
  plug :match
  plug :dispatch

  alias Ledger.Event, as: Event;
  alias Ledger.Repo, as: Repo;

  def maybe_decode(params, key) do
    if params[key] == nil do
      {:error, %{"error" => "No JSON detected"}}
    else
      case Poison.decode(params[key]) do
        {:ok, result} when is_map(result) ->
          {:ok, result}
        _ ->
          {:error, %{"error" => "Could not decode JSON"}}
      end
    end
  end

  def ip(conn) do
    conn.req_get_header("x-forwarded-for")
  end

  def base_event(conn) do
    %{
      "ip" => ip(conn),
    }
  end

  def write(event) do
    IO.puts "LedgerRouter#write #{event}"
    {:ok}
  end

  post "/batch" do
    IO.inspect conn
    conn |> send_resp(200, "ok")
  end


  get "/" do

    {_status, client_data} = conn.params |> maybe_decode("json")
    event = conn |> base_event |> Map.merge(client_data)
    write(event)

    conn
      |> put_resp_header("cache-control", "private, must-revalidate, max-age=0")
      |> send_resp(200, "OK")
  end

  get "/favicon.ico" do
    conn |> send_resp(200, "")
  end

  get "/status" do
    conn |> send_resp(200, "OK")
  end

  get "/v1/event" do
    {_status, client_data} = conn.params |> maybe_decode("json")

    # {:ok, ip} = ip(conn)

    event = %Event{
      type: "e",
      key: "key",
      device: "device",
      ip: "ip",
      data: client_data,
    }
    Repo.insert!(event)

    conn |> send_resp(200, "OK")
  end

  def email_open_params(conn) do
    params = conn.params
    if params["uniqid"] == nil do
      {:error, "Missing uniqid"}
    else
      {:ok, params["uniqid"]}
    end
  end

  get "/v1/email-open/:campaign/:user/a.png" do

    event = %Event{
      type: "e",
      key: "email-open",
      device: "",
      ip: "",
      data: %{
        "campaign" => campaign,
        "user" => user
      }
    }
    Repo.insert!(event)

    conn |> send_resp(200, "OK")
  end

end
