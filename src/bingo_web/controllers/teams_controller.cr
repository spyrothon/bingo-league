require "../../bingo_league/bingo"
require "../util/date_time.cr"

class BingoWeb::TeamsController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def index
    teams = Bingo.list_teams(Query.preload([:league]))
    render("teams/index.html.j2", {
      "teams" => teams
    })
  end

  def show
    if team = Bingo.get_team(url_params["team_id"], Query.preload([:league]))
      render("teams/show.html.j2", {
        "team" => team
      })
    else
      redirect_to teams_path
    end
  end

  def new
    team = Bingo.new_team()
    render("teams/new.html.j2", {
      "team" => team,
      "leagues" => Bingo.list_leagues()
    })
  end

  def create
    Bingo.create_team(body_params)
    redirect_to teams_path
  end

  def edit
    team_id = url_params["team_id"]
    if team = Bingo.get_team(team_id)
      render("teams/edit.html.j2", {
        "team" => team,
        "leagues" => Bingo.list_leagues()
      })
    else
      redirect_to teams_path
    end
  end

  def update
    team_id = url_params["team_id"]
    if team = Bingo.get_team(team_id)
      Bingo.update_team(team, body_params)
    end

    redirect_to teams_path
  end

  def delete
    team_id = url_params["team_id"]
    if team = Bingo.get_team(team_id)
      Bingo.delete_team(team)
    end

    redirect_to teams_path
  end
end
