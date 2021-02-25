defmodule Mix.Tasks.Process do
  use Mix.Task

  alias Hashcode2021Practice.Input
  alias Hashcode2021Practice.Model.World
  alias Hashcode2021Practice.Time

  def run(_) do
    EXLA.Application.start(:any, :thing)

    input = Time.measure(fn -> Input.read_world() end, "read")
    tensor = Time.measure(fn -> World.tensor(input) end, "tensor")
    IO.inspect "Tensor shape: #{tensor.shape}"
    distance_matrix = Time.measure(fn -> World.distance_matrix(tensor) end, "distance_matrix")
    |> IO.inspect()
  end
end
