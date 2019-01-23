require "../../fifteenfortyfive/contexts/bingo"

class MatchesController < BingoWebController
  def index
    matches = Bingo.list_matches()
    render("matches/index.html.j2", {
      "matches" => matches
    })
  end

  def show
    if match = Bingo.get_match(url_params["match_id"])
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
      "match" => match
    })
  end

  def create
    Bingo.create_match(body_params)
    redirect_to matches_path
  end

  def edit
    match_id = url_params["match_id"]
    if match = Bingo.get_match(match_id, Query.preload(:organization))
      render("matches/edit.html.j2", {
        "match" => match
      })
    else
      redirect_to matches_path
    end
  end

  def update
    match_id = url_params["match_id"]
    if match = Bingo.get_match(match_id)
      Bingo.update_match(match, body_params)
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
end
