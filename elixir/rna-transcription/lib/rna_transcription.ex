defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    # IO.puts("DNA to RNA: #{dna}")
    dnaMap = %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U}
    rna = Enum.map(dna, fn letter -> Map.get(dnaMap, letter) end)
    # IO.puts("RNA: #{to_string(rna)}")
    rna
  end
end
