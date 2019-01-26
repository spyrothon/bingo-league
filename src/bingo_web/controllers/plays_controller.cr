require "../../bingo_league/bingo"
require "../util/date_time.cr"

class BingoWeb::PlaysController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def index
    plays = Bingo.list_plays(Query.preload(:team))
    render("plays/index.html.j2", {
      "plays" => plays
    })
  end

  def show
    if play = Bingo.get_play(url_params["play_id"], Query.preload(:team))
      render("plays/show.html.j2", {
        "play" => play,
        "teams" => Bingo.list_teams()
      })
    else
      redirect_to plays_path
    end
  end

  def new
    play = Bingo.new_play()
    render("plays/new.html.j2", {
      "play" => play,
      "teams" => Bingo.list_teams()
    })
  end

  def create
    Bingo.create_play(body_params)
    redirect_to plays_path
  end

  def edit
    play_id = url_params["play_id"]
    if play = Bingo.get_play(play_id)
      render("plays/edit.html.j2", {
        "play" => play,
        "teams" => Bingo.list_teams()
      })
    else
      redirect_to plays_path
    end
  end

  def update
    play_id = url_params["play_id"]
    if play = Bingo.get_play(play_id)
      Bingo.update_play(play, body_params)
    end

    redirect_to plays_path
  end

  def delete
    play_id = url_params["play_id"]
    if play = Bingo.get_play(play_id)
      Bingo.delete_play(play)
    end

    redirect_to plays_path
  end
end
