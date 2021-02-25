defmodule Hashcode2021Practice.Model.World do
  defstruct [:pizzas, :teams2, :teams3, :teams4]

  use Bitwise
  import Nx.Defn
  alias Hashcode2021Practice.Model.World

  @default_defn_compiler {EXLA, run_options: [keep_on_device: true]}

  def ingredients_histogram(%World{pizzas: pizzas}) do
    pizzas
    |> Enum.reduce(%{}, fn pizza, acc ->
      Enum.reduce(pizza, acc, fn ingredient, acc ->
        if acc[ingredient] do
          Map.put(acc, ingredient, acc[ingredient] + 1)
        else
          Map.put(acc, ingredient, 1)
        end
      end)
    end)
    |> Map.to_list()
    |> List.keysort(1)
    |> Enum.reverse()
  end

  def pizzas_to_bin(%World{pizzas: pizzas} = world) do
    histogram = world |> ingredients_histogram() |> Enum.with_index()
    pins = for {{ingredient, _count}, index} <- histogram, into: %{} do
      {ingredient, index}
    end

    pizzas
    |> Enum.map(fn pizza ->
      pizza
      |> Enum.reduce(0, fn ingredient, acc ->
        (1 <<< pins[ingredient]) ||| acc
      end)
    end)
  end
end
