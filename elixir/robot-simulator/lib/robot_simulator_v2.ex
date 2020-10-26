# Using defined types this time

defmodule RobotSimulator do
  defstruct [:direction, :position]

  @type(dir :: :north, :east, :south, :west)
  @type pos :: {integer, integer}
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: dir, position :: pos) :: RobotSimulator
  def create(direction, position) do
    case {is_dir(direction), is_pos(position)} do
      {true, true} ->
        %RobotSimulator{direction: direction, position: position}

      {false, _} ->
        {:error, "invalid direction"}

      {_, false} ->
        {:error, "invalid position"}
    end
  end

  def create() do
    %RobotSimulator{direction: :north, position: {0, 0}}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.graphemes(instructions)
    |> Enum.reduce_while(robot, fn instruction, acc ->
      case instruction do
        "L" -> {:cont, turn(acc, instruction)}
        "R" -> {:cont, turn(acc, instruction)}
        "A" -> {:cont, advance(acc)}
        _ -> {:halt, {:error, "invalid instruction"}}
      end
    end)
  end

  @spec turn(robot :: RobotSimulator, turn :: String.t()) :: RobotSimulator
  defp turn(robot, turn) do
    newDir =
      case turn do
        "L" ->
          case robot.direction do
            :north -> :west
            :east -> :north
            :south -> :east
            :west -> :south
          end

        "R" ->
          case robot.direction do
            :north -> :east
            :east -> :south
            :south -> :west
            :west -> :north
          end
      end

    %RobotSimulator{robot | direction: newDir}
  end

  @spec advance(robot :: RobotSimulator) :: pos
  defp advance(robot) do
    {x, y} = robot.position

    newPos =
      case robot.direction do
        :north -> {x, y + 1}
        :east -> {x + 1, y}
        :south -> {x, y - 1}
        :west -> {x - 1, y}
      end

    %RobotSimulator{robot | position: newPos}
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

  @spec is_dir(direction :: any) :: boolean
  defp is_dir(direction) when is_atom(direction) do
    case direction do
      :north -> true
      :east -> true
      :south -> true
      :west -> true
      _ -> false
    end
  end

  defp is_dir(_) do
    false
  end

  @spec is_pos(position :: any) :: boolean
  defp is_pos(position) when is_tuple(position) and tuple_size(position) == 2 do
    {x, y} = position

    if is_integer(x) and is_integer(y) do
      true
    else
      false
    end
  end

  defp is_pos(_) do
    false
  end
end
