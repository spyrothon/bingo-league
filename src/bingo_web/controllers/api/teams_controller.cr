require "../../../bingo_league/bingo"

class BingoWeb::API::TeamsController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def index
    teams = Bingo.list_teams(Query.preload(:plays))
    render_json({
      teams: teams
    })
  end
end
