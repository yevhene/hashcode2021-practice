defmodule Hashcode2021Practice.Model.World do
  defstruct [:pizzas, :teams2, :teams3, :teams4]

  import Nx.Defn
  alias Hashcode2021Practice.Model.World

  @default_defn_compiler {EXLA, run_options: [keep_on_device: true]}

  def tensor(%World{pizzas: pizzas}) do
    ingredients =
      pizzas
      |> Enum.reduce(MapSet.new(), fn pizza, set ->
        MapSet.new(pizza) |> MapSet.union(set)
      end)
      |> MapSet.to_list()

    pizzas
    |> Enum.map(fn pizza ->
      ingredients
      |> Enum.map(fn ingredient ->
        if Enum.member?(pizza, ingredient), do: 1, else: 0
      end)
    end)
    |> Nx.tensor()
  end

  defn self_distance_matrix(a) do
    p1 = a |> Nx.sum(axes: [1], keep_axes: true)
    p2 = p1 |> Nx.transpose()
    p3 = a |> Nx.dot(Nx.transpose(a)) |> Nx.multiply(-2)
    p3 + p2 + p1
  end
end
