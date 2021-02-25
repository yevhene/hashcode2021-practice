defmodule Hashcode2021Practice.Model.World do
  defstruct [:pizzas, :teams2, :teams3, :teams4]

  import Nx.Defn
  alias Hashcode2021Practice.Model.World

  @default_defn_compiler EXLA

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

  defn(distance_matrix(a), do: distance_matrix(a, a))

  defn distance_matrix(a, b) do
    p1 = a |> Nx.power(2) |> Nx.sum(axes: [1], keep_axes: true)

    p2 =
      b |> Nx.power(2) |> Nx.sum(axes: [1], keep_axes: true) |> Nx.transpose()

    p3 = a |> Nx.dot(Nx.transpose(b)) |> Nx.multiply(-2)
    Nx.sqrt(p1 + p2 + p3)
  end
end
