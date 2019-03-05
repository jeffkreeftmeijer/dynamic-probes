defmodule ElixirProbes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ElixirProbes.Worker.start_link(arg)
      # {ElixirProbes.Worker, arg},
      {ProbeSupervisor, strategy: :one_for_one, name: ProbeSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirProbes.Supervisor]
    Supervisor.start_link(children, opts)

    ProbeSupervisor.start_child(:test_probe, TestProbe)
  end
end
