defmodule Mix.Tasks.Process do
  use Mix.Task

  alias Hashcode2021Practice.Input
  alias Hashcode2021Practice.Model.World
  alias Hashcode2021Practice.Time

  def run(_) do
    EXLA.Application.start(:any, :thing)

    input = Time.measure(fn -> Input.read_world() end, "read")
    IO.inspect("Pizzas: #{length(input.pizzas)}")

    tensor = Time.measure(fn -> World.tensor(input) end, "tensor")
    IO.inspect("Shape: #{tensor.shape |> elem(0)}x#{tensor.shape |> elem(1)}")

    Time.measure(
      fn ->
        World.self_distance_matrix(tensor)
      end,
      "distance_matrix"
    )
    |> Nx.backend_transfer()
    |> IO.inspect()
  end
end
