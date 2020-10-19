defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    matches = Regex.scan(~r/\w+/, sentence)
    IO.inspect(matches)
    count_words(matches, %{})
  end

  defp count_words([match | tail], result) do
    IO.puts("Match: #{match}")
    result = Map.update(result, String.downcase(match), 1, fn val -> val + 1 end)
    count_words(tail, result)
  end

  defp count_words([], result) do
    result
  end
end
