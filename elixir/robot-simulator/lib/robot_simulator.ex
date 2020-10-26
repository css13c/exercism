defmodule RobotSimulator2 do
  defstruct direction: :north, position: {0, 0}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ nil, position \\ nil) do
    invalid_direction = {:error, "invalid direction"}
    invalid_position = {:error, "invalid position"}

    # Validate inputs
    cond do
      # Direction validation
      !is_atom(direction) ->
        invalid_direction

      direction == :invalid ->
        invalid_direction

      # Position validation
      position != nil && !is_tuple(position) ->
        invalid_position

      position != nil && (!is_integer(elem(position, 0)) || !is_integer(elem(position, 1))) ->
        invalid_position

      position != nil && tuple_size(position) != 2 ->
        invalid_position

      # Single argument validation
      direction == nil && position != nil ->
        invalid_direction

      position == nil && direction != nil ->
        invalid_position

      direction != nil && position != nil ->
        %RobotSimulator{direction: direction, position: position}

      true ->
        %RobotSimulator{}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    if String.match?(instructions, ~r/[^LRA]/) do
      {:error, "invalid instruction"}
    else
      String.graphemes(instructions)
      |> Enum.reduce(robot, fn instruction, acc ->
        if instruction == "A" do
          {x, y} = acc.position

          %RobotSimulator{
            acc
            | position:
                case acc.direction do
                  :north -> {x, y + 1}
                  :east -> {x + 1, y}
                  :south -> {x, y - 1}
                  :west -> {x - 1, y}
                end
          }
        else
          %RobotSimulator{acc | direction: get_turn(acc.direction, instruction)}
        end
      end)
    end
  end

  @spec get_turn(direction :: atom, turn :: String.t()) :: atom
  defp get_turn(direction, turn) do
    isLeft = turn == "L"

    case direction do
      :north ->
        if isLeft do
          :west
        else
          :east
        end

      :east ->
        if isLeft do
          :north
        else
          :south
        end

      :south ->
        if isLeft do
          :east
        else
          :west
        end

      :west ->
        if isLeft do
          :south
        else
          :north
        end
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
