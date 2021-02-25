defmodule Mix.Tasks.Process do
  use Mix.Task

  alias Hashcode2021Practice.Input
  alias Hashcode2021Practice.Model.World

  def run(_) do
    EXLA.Application.start(:any, :thing)

    Input.read_world()
    |> World.tensor()
    |> World.distance_matrix()
    |> IO.inspect()
  end
end
