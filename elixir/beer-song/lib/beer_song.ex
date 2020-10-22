defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    # Your implementation here...
    cond do
      number > 1 ->
        """
        #{number} bottles of beer on the wall, #{number} bottles of beer.
        Take one down and pass it around, #{number - 1} #{
          if number - 1 == 1 do
            "bottle"
          else
            "bottles"
          end
        } of beer on the wall.
        """

      number == 1 ->
        "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"

      true ->
        "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    # Your implementation here...
    Enum.reduce(range, "", fn x, acc ->
      last =
        if Enum.at(range, Enum.count(range) - 1) == x do
          ""
        else
          "\n"
        end

      acc <> verse(x) <> last
    end)
  end
end
