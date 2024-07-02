defmodule BatalhaNaval.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BatalhaNavalWeb.Telemetry,
      BatalhaNaval.Repo,
      {DNSCluster, query: Application.get_env(:batalha_naval, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BatalhaNaval.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BatalhaNaval.Finch},
      # Start a worker by calling: BatalhaNaval.Worker.start_link(arg)
      # {BatalhaNaval.Worker, arg},
      # Start to serve requests, typically the last entry
      BatalhaNavalWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BatalhaNaval.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BatalhaNavalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
