defmodule RomanNumerals do
  @roman %{
    1000 => "M",
    100 => "C",
    10 => "X",
    1 => "I"
  }

  @doc """
  Convert the number to a roman number.

  Process:
    - Reduce string, starting new reduction for
    - 3 possible cases for each letter:
      - 1:
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    keysList = Map.keys(@roman) |> Enum.sort(:desc)
    get_roman(0, keysList, "", number)
  end

  defp get_roman(_index, _list, acc, number) when number <= 0 do
    acc
  end

  defp get_roman(index, list, acc, number) when number > 0 do
    int = Enum.at(list, index)
    dividend = div(number, int)

    fives = %{500 => "D", 50 => "L", 5 => "V"}

    append =
      cond do
        dividend == 9 ->
          "#{@roman[int]}#{@roman[Enum.at(list, index - 1)]}"

        dividend >= 5 and dividend < 9 ->
          "#{fives[int * 5]}#{print_multiple(@roman[int], dividend - 5, "")}"

        dividend == 4 ->
          "#{@roman[Enum.at(list, index)]}#{fives[int * 5]}"

        dividend < 4 and dividend > 0 ->
          print_multiple(@roman[int], dividend, "")

        true ->
          ""
      end

    get_roman(index + 1, list, acc <> append, rem(number, int))
  end

  defp print_multiple(val, count, acc) when count > 0 do
    print_multiple(val, count - 1, acc <> val)
  end

  defp print_multiple(_val, count, acc) when count == 0 do
    acc
  end
end
