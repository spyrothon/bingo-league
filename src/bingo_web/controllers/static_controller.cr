require "../../bingo_league/league"

class BingoWeb::StaticController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias League = BingoLeague::League

  def index
    teams = League.list_teams()
    render("static/index.html.j2")
  end

  def play
    render("static/play.html.j2")
  end

  def admin
    render("static/admin.html.j2")
  end
end
