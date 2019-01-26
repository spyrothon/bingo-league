require "../../../bingo_league/bingo"

class BingoWeb::API::LeaguesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def show
    league_id = url_params["league_id"]
    for_league = Query.where(league_id: league_id)

    league = Bingo.get_league!(league_id)
    matches = Bingo.list_matches(for_league)
    teams = Bingo.list_teams(for_league)

    players = Bingo.list_players(Query.where(team_id: teams.map(&.id)))
    plays = Bingo.list_plays(Query.where(match_id: matches.map(&.id)))

    render_json({
      league: league,
      matches: matches.index_by(&.id),
      players: players.index_by(&.id),
      plays: plays.index_by(&.id),
      teams: teams.index_by(&.id)
    })
  end
end
