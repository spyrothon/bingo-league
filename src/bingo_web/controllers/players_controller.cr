require "../../bingo_league/league"
require "../util/date_time.cr"

class BingoWeb::PlayersController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias League = BingoLeague::League

  def index
    players = League.list_players(Query.preload(:team))
    render("players/index.html.j2", {
      "players" => players
    })
  end

  def show
    if player = League.get_player(url_params["player_id"], Query.preload(:team))
      render("players/show.html.j2", {
        "player" => player,
        "teams" => League.list_teams()
      })
    else
      redirect_to players_path
    end
  end

  def new
    player = League.new_player()
    render("players/new.html.j2", {
      "player" => player,
      "teams" => League.list_teams()
    })
  end

  def create
    League.create_player(body_params)
    redirect_to players_path
  end

  def edit
    player_id = url_params["player_id"]
    if player = League.get_player(player_id)
      render("players/edit.html.j2", {
        "player" => player,
        "teams" => League.list_teams()
      })
    else
      redirect_to players_path
    end
  end

  def update
    player_id = url_params["player_id"]
    if player = League.get_player(player_id)
      League.update_player(player, body_params)
    end

    redirect_to players_path
  end

  def delete
    player_id = url_params["player_id"]
    if player = League.get_player(player_id)
      League.delete_player(player)
    end

    redirect_to players_path
  end
end
