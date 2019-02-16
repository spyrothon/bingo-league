require "../../bingo_league/league"
require "../util/date_time.cr"

class BingoWeb::MatchesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Multi = BingoLeague::Multi
  private alias League = BingoLeague::League

  def index
    matches = League.list_matches(Query.order_by("start_date ASC"))
    render("matches/index.html.j2", {
      "matches" => matches
    })
  end

  def show
    match = League.get_match(url_params["match_id"])

    if match
      render("matches/show.html.j2", {
        "match" => match
      })
    else
      redirect_to matches_path
    end
  end

  def new
    match = League.new_match()
    render("matches/new.html.j2", {
      "match" => match,
      "teams" => League.list_teams()
    })
  end

  def create
    params = body_params.merge({
      "start_date" => Util.maybe_parse_date_time(body_params["start_date"])
    })
    League.create_match(params)
    redirect_to matches_path
  end

  def edit
    match = League.get_match(url_params["match_id"])

    if match
      render("matches/edit.html.j2", {
        "match" => match,
        "teams" => League.list_teams()
      })
    else
      redirect_to matches_path
    end
  end

  def update
    match_id = url_params["match_id"]
    if match = League.get_match(match_id)
      params = body_params.merge({
        "start_date" => Util.maybe_parse_date_time(body_params["start_date"])
      })
      League.update_match(match, params)
    end

    redirect_to matches_path
  end

  def delete
    match_id = url_params["match_id"]
    if match = League.get_match(match_id)
      League.delete_match(match)
    end

    redirect_to matches_path
  end
end
