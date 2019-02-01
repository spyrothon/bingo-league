require "../../bingo_league/bingo"

class BingoWeb::StaticController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def index
    teams = Bingo.list_teams()
    render("static/index.html.j2")
  end

  def admin
    render("static/admin.html.j2")
  end
end
