defmodule StringHelper do
  @moduledoc """
  Utility functions for strings that aren't implemented in the `String` module
  """

  @doc """
  Compares string equivilence, ignoring case
  """
  @spec ignore_case_compare(String.t(), String.t()) :: boolean
  def ignore_case_compare(str1, str2) do
    up1 = String.upcase(str1)

    String.upcase(str2)
    |> String.equivalent?(up1)
  end
end
