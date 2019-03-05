defmodule TestProbe do
  def call do
    if :rand.uniform() < 0.1 do
      raise "KRAK!"
    end

    IO.puts("***")
  end
end
