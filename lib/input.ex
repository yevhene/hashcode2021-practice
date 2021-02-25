defmodule Hashcode2021Practice.Input do
  defstruct [:pizzas, :teams2, :teams3, :teams4]

  alias Hashcode2021Practice.Model.World

  def read_world do
    [count, teams2, teams3, teams4] = read_header()
    pizzas = read_pizzas()

    ^count = length(pizzas)

    %World{
      teams2: teams2,
      teams3: teams3,
      teams4: teams4,
      pizzas: pizzas
    }
  end

  defp read_pizzas do
    IO.stream(:stdio, :line)
    |> Enum.map(&process_pizza/1)
  end

  defp process_pizza(string) do
    [count | ingredients] = string |> String.split(" ", trim: true)
    count = String.to_integer(count)

    ^count = length(ingredients)

    ingredients
  end

  defp read_header do
    IO.read(:stdio, :line)
    |> String.split([" ", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
