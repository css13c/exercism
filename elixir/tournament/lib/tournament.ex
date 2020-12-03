defmodule Tournament do
  defmodule Team do
    @enforce_keys [:name]
    defstruct [:name, played: 0, wins: 0, draws: 0, losses: 0, points: 0]

    @spec get_output(team :: %Team{}) :: String.t()
    def get_output(team = %Team{}) do
      """
      #{String.pad_trailing(team.name, 30)} |#{
        Integer.to_string(team.played) |> String.pad_leading(3)
      } |#{Integer.to_string(team.wins) |> String.pad_leading(3)} |#{
        Integer.to_string(team.draws) |> String.pad_leading(3)
      } |#{Integer.to_string(team.losses) |> String.pad_leading(3)} |#{
        Integer.to_string(team.points) |> String.pad_leading(3)
      }
      """
      |> String.trim()
    end
  end

  @typep(match_result :: :win, :lose, :draw)

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    output_base = "#{String.pad_trailing("Team", 30)} | MP |  W |  D |  L |  P"

    team_output =
      Enum.reduce(input, %{}, fn x, acc ->
        [team1, team2, result] = String.split(x, ";")

        Map.update(
          acc,
          team1,
          update_team(%Team{name: team1}, cast_result(result, true)),
          fn val ->
            update_team(val, cast_result(result, true))
          end
        )
        |> Map.update(
          team2,
          update_team(%Team{name: team2}, cast_result(result, false)),
          fn val ->
            update_team(val, cast_result(result, false))
          end
        )
      end)
      |> Map.values()
      |> Enum.reduce(%{}, fn x, acc ->
        Map.update(acc, x.points, [x], fn val -> val ++ x end)
      end)
      |> Map.values()
      |> IO.inspect(label: "List")
      |> Enum.flat_map(fn i -> Enum.sort_by(i, fn x -> x.name end, :desc) end)
      |> Enum.sort_by(&{&1.points, &1.name}, :desc)
      |> Enum.map(&Tournament.Team.get_output(&1))
      |> Enum.join("\n")

    """
    #{output_base}
    #{team_output}
    """
    |> String.trim()
  end

  @spec update_team(team :: %Tournament.Team{}, result :: match_result) :: %Tournament.Team{}
  defp update_team(team, result) do
    case result do
      :draw ->
        %Tournament.Team{
          team
          | played: team.played + 1,
            draws: team.draws + 1,
            points: team.points + 1
        }

      :win ->
        %Tournament.Team{
          team
          | played: team.played + 1,
            wins: team.wins + 1,
            points: team.points + 3
        }

      :loss ->
        %Tournament.Team{team | played: team.played + 1, losses: team.losses + 1}
    end
  end

  @spec cast_result(result :: String.t(), is_team_1 :: boolean) :: match_result
  defp cast_result(result, is_team_1) do
    case {result, is_team_1} do
      {"win", true} -> :win
      {"loss", false} -> :win
      {"loss", true} -> :loss
      {"win", false} -> :loss
      _ -> :draw
    end
  end
end
