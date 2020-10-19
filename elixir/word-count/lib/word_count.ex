defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    matches = Regex.split(~r/[^\p{L}0-9-]+/u, sentence) |> Enum.filter(fn x -> x != "" end)
    count_words(matches, %{})
  end

  # Better solution (using method chaining):
  def count_alt(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/(?!-)[[:space:][:punct:]]/ui)
    |> Enum.reduce(%{}, fn x, acc ->
      Map.update(acc, x, 1, &(&1 + 1))
    end)
  end

  defp count_words([match | tail], result) do
    result = Map.update(result, String.downcase(match), 1, fn val -> val + 1 end)
    count_words(tail, result)
  end

  defp count_words([], result) do
    result
  end
end
