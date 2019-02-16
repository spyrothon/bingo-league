require "../../bingo_league/league"
require "../util/date_time.cr"

class BingoWeb::TeamsController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias League = BingoLeague::League

  def index
    teams = League.list_teams()
    render("teams/index.html.j2", {
      "teams" => teams
    })
  end

  def show
    if team = League.get_team(url_params["team_id"])
      render("teams/show.html.j2", {
        "team" => team
      })
    else
      redirect_to teams_path
    end
  end

  def new
    team = League.new_team()
    render("teams/new.html.j2", {
      "team" => team
    })
  end

  def create
    League.create_team(body_params)
    redirect_to teams_path
  end

  def edit
    team_id = url_params["team_id"]
    if team = League.get_team(team_id)
      render("teams/edit.html.j2", {
        "team" => team
      })
    else
      redirect_to teams_path
    end
  end

  def update
    team_id = url_params["team_id"]
    if team = League.get_team(team_id)
      League.update_team(team, body_params)
    end

    redirect_to teams_path
  end

  def delete
    team_id = url_params["team_id"]
    if team = League.get_team(team_id)
      League.delete_team(team)
    end

    redirect_to teams_path
  end
end
