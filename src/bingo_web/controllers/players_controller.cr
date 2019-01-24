require "../../bingo_league/bingo"
require "../util/date_time.cr"

class BingoWeb::PlayersController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def index
    players = Bingo.list_players()
    render("players/index.html.j2", {
      "players" => players
    })
  end

  def show
    if player = Bingo.get_player(url_params["player_id"])
      render("players/show.html.j2", {
        "player" => player
      })
    else
      redirect_to players_path
    end
  end

  def new
    player = Bingo.new_player()
    render("players/new.html.j2", {
      "player" => player,
      "teams" => Bingo.list_teams()
    })
  end

  def create
    Bingo.create_player(body_params)
    redirect_to players_path
  end

  def edit
    player_id = url_params["player_id"]
    if player = Bingo.get_player(player_id)
      render("players/edit.html.j2", {
        "player" => player,
        "teams" => Bingo.list_teams()
      })
    else
      redirect_to players_path
    end
  end

  def update
    player_id = url_params["player_id"]
    if player = Bingo.get_player(player_id)
      Bingo.update_player(player, body_params)
    end

    redirect_to players_path
  end

  def delete
    player_id = url_params["player_id"]
    if player = Bingo.get_player(player_id)
      Bingo.delete_player(player)
    end

    redirect_to players_path
  end
end
