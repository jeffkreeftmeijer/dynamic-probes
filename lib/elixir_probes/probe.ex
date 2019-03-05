defmodule Probe do
  use GenServer

  def start_link(fun) do
    GenServer.start_link(__MODULE__, fun)
  end

  def init(fun) do
    schedule()
    {:ok, fun}
  end

  def handle_info(:work, fun) do
    fun.()
    schedule()
    {:noreply, fun}
  end

  defp schedule() do
    Process.send_after(self(), :work, 100)
  end
end
