require "../../../bingo_league/bingo"

class BingoWeb::API::LeaguesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def show
    league = Bingo.get_league!(
      url_params["league_id"],
      Query.
        preload(:matches, Query.preload(:plays)).
        preload(:teams, Query.preload(:players))
    )

    render_json(league)
  end
end
