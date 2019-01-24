require "../../bingo_league/bingo"
require "../util/date_time.cr"

class BingoWeb::MatchesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def index
    matches = Bingo.list_matches(Query.preload(:league))
    render("matches/index.html.j2", {
      "matches" => matches
    })
  end

  def show
    if match = Bingo.get_match(url_params["match_id"], Query.preload(:league))
      render("matches/show.html.j2", {
        "match" => match
      })
    else
      redirect_to matches_path
    end
  end

  def new
    match = Bingo.new_match()
    render("matches/new.html.j2", {
      "match" => match,
      "leagues" => Bingo.list_leagues()
    })
  end

  def create
    params = body_params.merge({
      "start_date" => Util.maybe_parse_date_time(body_params["start_date"])
    })
    Bingo.create_match(params)
    redirect_to matches_path
  end

  def edit
    match_id = url_params["match_id"]
    if match = Bingo.get_match(match_id, Query.preload(:league))
      render("matches/edit.html.j2", {
        "match" => match,
        "leagues" => Bingo.list_leagues()
      })
    else
      redirect_to matches_path
    end
  end

  def update
    match_id = url_params["match_id"]
    if match = Bingo.get_match(match_id)
      params = body_params.merge({
        "start_date" => Util.maybe_parse_date_time(body_params["start_date"])
      })
      Bingo.update_match(match, params)
    end

    redirect_to matches_path
  end

  def delete
    match_id = url_params["match_id"]
    if match = Bingo.get_match(match_id)
      Bingo.delete_match(match)
    end

    redirect_to matches_path
  end
end
