defmodule Mix.Tasks.Process do
  use Mix.Task

  alias Hashcode2021Practice.Input
  alias Hashcode2021Practice.Model.World
  alias Hashcode2021Practice.Time

  def run(_) do
    EXLA.Application.start(:any, :thing)

    world = Time.measure(fn -> Input.read_world() end, "read")
    IO.puts("Pizzas: #{length(world.pizzas)}")

     Time.measure(fn ->
      World.pizzas_to_bin(world)
    end, "pizzas_to_bin")
    |> IO.inspect()

    #|> Nx.backend_transfer()
  end
end
