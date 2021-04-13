defmodule BasicServer.Endpoints do
  @moduledoc false
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Welcome")
  end

  get "/json" do
    body = %{Name: "John"}
    send_resp(conn, 200, Jason.encode!(body))
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end
