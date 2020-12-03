defmodule Bob do
  def hey(input) do
    # IO.inspect(input, label: "Input")
    phrase = String.trim(input)
    yelling = String.upcase(phrase) == phrase and String.match?(phrase, ~r/\p{Lu}+/u)
    question = String.ends_with?(phrase, "?")

    # IO.inspect(yelling, label: "Yelling")
    # IO.inspect(question, label: "Question")

    cond do
      phrase === "" ->
        "Fine. Be that way!"

      yelling and question ->
        "Calm down, I know what I'm doing!"

      question ->
        "Sure."

      yelling ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end
end
