require "../../bingo_league/bingo"
require "../util/date_time.cr"

class BingoWeb::MatchesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Multi = BingoLeague::Multi
  private alias Bingo = BingoLeague::Bingo

  def index
    matches = Bingo.list_matches(Query.preload(:league))
    render("matches/index.html.j2", {
      "matches" => matches
    })
  end

  def show
    match = Bingo.get_match(
      url_params["match_id"],
      Query.
        preload(:league).
        preload(:teams).
        preload(:plays, Query.preload(:team))
    )

    if match
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
      "leagues" => Bingo.list_leagues(),
      "teams" => Bingo.list_teams()
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
    match = Bingo.get_match(
      url_params["match_id"],
      Query.
        preload(:teams).
        preload(:plays, Query.preload([:player, :team]))
    )

    if match
      render("matches/edit.html.j2", {
        "match" => match,
        "leagues" => Bingo.list_leagues(),
        "teams" => Bingo.list_teams()
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


  def add_team
    team_id   = body_params["team_id"]
    match_id  = url_params["match_id"]
    players = Bingo.list_players(Query.where(team_id: team_id))

    players.each do |player|
      Bingo.create_play({
        "player_id" => player.id,
        "team_id" => team_id,
        "match_id" => match_id
      })
    end

    redirect_to matches_edit_path(match_id: match_id)
  end

  def remove_team
    team_id   = url_params["team_id"]
    match_id  = url_params["match_id"]
    plays = Bingo.list_plays(Query.where(team_id: team_id))

    plays.each{ |p| Bingo.delete_play(p) }

    redirect_to matches_edit_path(match_id: match_id)
  end
end
