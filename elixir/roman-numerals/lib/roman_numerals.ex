defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.

  Process:
    - Reduce string, starting new reduction for
    - 3 possible cases for each letter:
      - 1:
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    values = %{
      1000 => "M",
      500 => "D",
      100 => "C",
      50 => "L",
      10 => "X",
      5 => "V",
      1 => "I"
    }

    keysList = Map.keys(values) |> Enum.sort(:desc)
    Enum.reduce(keysList, "", fn int, acc ->
      # Get the divisor and remainder
      divisor = div(number, int)
      remainder = rem(number, int)
      append = nil
      if remainder == 9 do
        index = Enum.find_index(keysList, &(&1 == int))
        append = "#{values[keysList[index-1]])}#{values[keysList[index+1]]}"
      else if result == 4 do

      else
      end
    end)
  end

    defp reduce_num(num) do
  end

  defp reduce_num(0, string) do
    acc
  end
end
