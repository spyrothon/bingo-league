require "../../bingo_league/bingo"
require "../util/date_time.cr"

class BingoWeb::LeaguesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def index
    leagues = Bingo.list_leagues(Query.preload(:matches))
    render("leagues/index.html.j2", {
      "leagues" => leagues
    })
  end

  def show
    if league = Bingo.get_league(url_params["league_id"],
          Query.preload(:matches, Query.preload([:teams, :players]))
        )
      render("leagues/show.html.j2", {
        "league" => league
      })
    else
      redirect_to leagues_path
    end
  end

  def new
    league = Bingo.new_league()
    render("leagues/new.html.j2", {
      "league" => league,
      "leagues" => Bingo.list_leagues()
    })
  end

  def create
    Bingo.create_league(body_params)
    redirect_to leagues_path
  end

  def edit
    league_id = url_params["league_id"]
    if league = Bingo.get_league(league_id, Query.preload(:matches))
      render("leagues/edit.html.j2", {
        "league" => league,
        "leagues" => Bingo.list_leagues()
      })
    else
      redirect_to leagues_path
    end
  end

  def update
    league_id = url_params["league_id"]
    if league = Bingo.get_league(league_id)
      Bingo.update_league(league, body_params)
    end

    redirect_to leagues_path
  end

  def delete
    league_id = url_params["league_id"]
    if league = Bingo.get_league(league_id)
      Bingo.delete_league(league)
    end

    redirect_to leagues_path
  end
end
