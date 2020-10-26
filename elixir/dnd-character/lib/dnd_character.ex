defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    Integer.floor_div(score - 10, 2)
  end

  @spec ability :: pos_integer()
  def ability do
    :rand.seed(:exsplus, 500)
    rolls = [:rand.uniform(6), :rand.uniform(6), :rand.uniform(6), :rand.uniform(6)]
    min = Enum.min(rolls)

    Enum.reduce(rolls, fn x, sum ->
      if x != min do
        sum + x
      else
        sum
      end
    end)
  end

  @spec character :: t()
  def character do
    con = ability()

    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: con,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: 10 + modifier(con)
    }
  end
end
