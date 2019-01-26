require "../../../bingo_league/bingo"
require "../../util/date_time"

class BingoWeb::API::MatchesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def create
    if match = Bingo.create_match_from_json(raw_request_body)
      render_json({
        hi: :yes
      })
    else
      render_error(422, "woops")
    end
  end
end
