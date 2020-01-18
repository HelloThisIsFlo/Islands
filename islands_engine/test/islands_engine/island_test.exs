defmodule IslandsEngine.IslandTest do
  use ExUnit.Case
  alias IslandsEngine.{Coordinate, Island}

  describe "Valid Island" do
    test "Square" do
      {:ok, upper_left} = Coordinate.new(2, 1)
      assert {:ok, island} = Island.new(:square, upper_left)

      assert MapSet.equal?(
               island.coordinates,
               MapSet.new([
                 %Coordinate{col: 2, row: 1},
                 %Coordinate{col: 2, row: 2},
                 %Coordinate{col: 3, row: 1},
                 %Coordinate{col: 3, row: 2}
               ])
             )
    end

    test "Atol" do
      {:ok, upper_left} = Coordinate.new(2, 1)
      assert {:ok, island} = Island.new(:atol, upper_left)

      assert MapSet.equal?(
               island.coordinates,
               MapSet.new([
                 %Coordinate{col: 2, row: 1},
                 %Coordinate{col: 3, row: 1},
                 %Coordinate{col: 3, row: 2},
                 %Coordinate{col: 3, row: 3},
                 %Coordinate{col: 2, row: 3}
               ])
             )
    end
    test "Dot" do
      {:ok, upper_left} = Coordinate.new(2, 1)
      assert {:ok, island} = Island.new(:dot, upper_left)

      assert MapSet.equal?(
               island.coordinates,
               MapSet.new([
                 %Coordinate{col: 2, row: 1},
               ])
             )
    end

    test "L shape" do
      {:ok, upper_left} = Coordinate.new(2, 1)
      assert {:ok, island} = Island.new(:l_shape, upper_left)

      assert MapSet.equal?(
               island.coordinates,
               MapSet.new([
                 %Coordinate{col: 2, row: 1},
                 %Coordinate{col: 2, row: 2},
                 %Coordinate{col: 2, row: 3},
                 %Coordinate{col: 3, row: 3},
               ])
             )
    end

    test "S shape" do
      {:ok, upper_left} = Coordinate.new(2, 1)
      assert {:ok, island} = Island.new(:s_shape, upper_left)

      assert MapSet.equal?(
               island.coordinates,
               MapSet.new([
                 %Coordinate{col: 2, row: 2},
                 %Coordinate{col: 3, row: 2},
                 %Coordinate{col: 3, row: 1},
                 %Coordinate{col: 4, row: 1},
               ])
             )
    end
  end

  test "Invalid coordinate" do
    {:ok, upper_left} = Coordinate.new(10, 1)
    assert {:error, :invalid_coordinate} = Island.new(:l_shape, upper_left)
  end
end
