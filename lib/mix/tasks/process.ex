defmodule Mix.Tasks.Process do
  use Mix.Task

  alias Hashcode2021Practice.Model.World

  def run(args) do
    if length(args) == 1 do
      args
      |> Enum.at(0)
      |> File.read!()
      |> World.build()
      |> World.table()
      |> IO.inspect()
    else
      help()
    end
  end

  defp help() do
    IO.puts("mix process 'filename'")
  end
end
