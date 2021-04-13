defmodule BasicServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: BasicServer.Worker.start_link(arg)
      # {BasicServer.Worker, arg}
      {Plug.Cowboy,
       scheme: :http,
       plug: Endpoints,
       options: [port: Application.get_env(:basic_server, :port, 4000)]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BasicServer.Supervisor]

    Logger.info(
      "Server is starting at port #{Application.get_env(:basic_server, :port, 4000)}\n \t\t\tOpen at http://127.0.0.1:#{
        Application.get_env(:basic_server, :port, 4000)
      }/"
    )

    Supervisor.start_link(children, opts)
  end
end
