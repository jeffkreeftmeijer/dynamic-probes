defmodule ProbeSupervisor do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(name, module) do
    DynamicSupervisor.start_child(__MODULE__, %{
      id: name,
      start: {Probe, :start_link, [&module.call/0]}
    })
  end
end
