defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    shift = rem(shift, 26)
    IO.puts("\n\nShifting: #{text}")
    IO.inspect(shift, label: "Shift")

    String.to_charlist(text)
    |> Enum.map(&shift_char(&1, shift))
    |> List.to_string()
  end

  defguardp is_lowercase(char) when char >= ?a and char <= ?z
  defguardp is_uppercase(char) when char >= ?A and char <= ?Z

  @spec shift_char(char :: non_neg_integer(), shift :: integer()) :: non_neg_integer()
  defp shift_char(char, shift) when is_lowercase(char) do
    cond do
      char + shift < ?a -> char + 26 + shift
      char + shift > ?z -> char - 26 + shift
      true -> char + shift
    end
  end

  defp shift_char(char, shift) when is_uppercase(char) do
    cond do
      char + shift < ?A -> char + 26 + shift
      char + shift > ?Z -> char - 26 + shift
      true -> char + shift
    end
  end

  defp shift_char(char, _) do
    char
  end
end
