defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    words =
    for word <- String.split(phrase) do
      Enum.reduce_while()
      for letter <- String.graphemes(word) do
        case {is_consonant(letter), is_vowel(letter)} do
          {true, false} ->
          {false, true} ->
        end
      end
    end
  end


  @specialConsonants MapSet.new(["ch", "qu", "squ", "th", "thr", "sch"])
  @vowels MapSet.new(["a", "e", "i", "o", "u", "yt", "xr"])

  defp is_consonant(letter) do
    MapSet.member?(@specialConsonants, letter) or not MapSet.member?(@vowels, letter)
  end

  defp is_vowel(letter) do
    MapSet.member?(@vowels, letter)
  end
end
