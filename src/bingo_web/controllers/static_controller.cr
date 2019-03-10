require "../../bingo_league/league"
require "../../bingo_league/rooms"

class BingoWeb::StaticController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias League = BingoLeague::League

  def index
    teams = League.list_teams()
    render("static/index.html.j2")
  end

  def goals
    goals = Rooms::Context.list_goals().sort_by{ |g| g.name.not_nil! }
    render("static/goals.html.j2", {
      "goals" => goals
    })
  end

  def play
    render("static/play.html.j2")
  end

  def admin
    render("static/admin.html.j2")
  end
end
