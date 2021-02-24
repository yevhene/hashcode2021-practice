defmodule Hashcode2021Practice.Model.World do
  defstruct [:pizzas, :teams2, :teams3, :teams4]

  alias Hashcode2021Practice.Model.Pizza
  alias Hashcode2021Practice.Model.World

  def table(%World{pizzas: pizzas}) do
    ingredients =
      pizzas
      |> Enum.reduce(MapSet.new(), fn pizza, set ->
        MapSet.new(pizza.ingredients) |> MapSet.union(set)
      end)
      |> MapSet.to_list()

    pizzas
    |> Enum.map(fn pizza ->
      ingredients
      |> Enum.map(fn ingredient ->
        if Enum.member?(pizza.ingredients, ingredient), do: 1, else: 0
      end)
    end)
  end

  def build(data) do
    strings = data |> String.split("\n", trim: true)
    [_count, teams2, teams3, teams4] = strings |> Enum.at(0) |> process_header()
    pizzas = strings |> Enum.drop(1) |> Enum.map(&process_pizza/1)

    %World{
      teams2: teams2,
      teams3: teams3,
      teams4: teams4,
      pizzas: pizzas
    }
  end

  defp process_header(string) do
    string
    |> String.split(" ", trim: true)
    |> Enum.map(&parse_int/1)
  end

  defp process_pizza(string) do
    %Pizza{ingredients: string |> String.split(" ", trim: true) |> Enum.drop(1)}
  end

  defp parse_int(string) do
    {value, _} = Integer.parse(string)
    value
  end
end
