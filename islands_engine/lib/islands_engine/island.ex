defmodule IslandsEngine.Island do
  alias IslandsEngine.{Coordinate, Guesses}
  alias __MODULE__

  @enforce_keys [:coordinates]
  defstruct [:coordinates, hit_coordinates: MapSet.new()]

  def new(),
    do: %Island{coordinates: MapSet.new(), hit_coordinates: MapSet.new()}

  def new(type, %Coordinate{} = upper_left) do
    with [_ | _] = offsets <- offsets(type),
         %MapSet{} = coordinates <- add_coordinates(offsets, upper_left) do
      {:ok, %Island{coordinates: coordinates}}
    else
      error -> error
    end
  end

  def sandbox do
  end

  defp add_coordinates(offsets, upper_left) do
    Enum.reduce_while(offsets, MapSet.new(), fn offset, acc ->
      add_coordinate(acc, upper_left, offset)
    end)
  end

  defp add_coordinate(
         coordinates,
         %Coordinate{row: row_ul, col: col_ul},
         {row_offset, col_offset}
       ) do
    case Coordinate.new(row_ul + row_offset, col_ul + col_offset) do
      {:ok, coord} ->
        {:cont, MapSet.put(coordinates, coord)}

      {:error, :invalid_coordinate} ->
        {:halt, {:error, :invalid_coordinate}}
    end
  end

  defp offsets(:square),
    do: [{0, 0}, {0, 1}, {1, 0}, {1, 1}]

  defp offsets(:atol),
    do: [{0, 0}, {0, 1}, {1, 1}, {2, 0}, {2, 1}]

  defp offsets(:dot),
    do: [{0, 0}]

  defp offsets(:l_shape),
    do: [{0, 0}, {1, 0}, {2, 0}, {2, 1}]

  defp offsets(:s_shape),
    do: [{0, 1}, {0, 2}, {1, 0}, {1, 1}]

  defp offsets(_),
    do: {:error, :invalid_island_type}
end