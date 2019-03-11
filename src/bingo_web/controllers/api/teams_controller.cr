require "../../../bingo_league/league"

class BingoWeb::API::TeamsController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias League = BingoLeague::League

  def index
    teams = League.list_teams(Query.preload(:plays, Query.preload(:match)))

    render_json({
      teams: teams
    })
  end
end
