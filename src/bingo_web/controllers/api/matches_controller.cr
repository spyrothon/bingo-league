require "../../../bingo_league/bingo"

class BingoWeb::API::MatchesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias Bingo = BingoLeague::Bingo

  def index
    matches = Bingo.list_matches()
    render_json({
      matches: matches
    })
  end

  def show
    match = Bingo.get_match(url_params["match_id"])
    render_json({ match: match })
  end

  def new
    match = Bingo.new_match()
    render_json({ match: match })
  end

  def create
    changeset = Bingo.create_match(body_params)

    if changeset.valid?
      match = changeset.instance
      render_json({ match: match })
    else
      pp changeset
      render_error_json(422, "Couldn't create match")
    end
  end

  def edit
    match = Bingo.get_match(url_params["match_id"])

    if match
      render_json({ match: match })
    else
      render_error_json(404, "Couldn't find match")
    end
  end

  def update
    match_id = url_params["match_id"]
    unless match = Bingo.get_match(match_id)
      render_error_json(404, "Couldn't find match")
      return
    end

    changeset = Bingo.update_match(match, body_params)
    if changeset.valid?
      match = changeset.instance
      render_json({ match: match })
    else
      render_error_json(422, "Couldn't create match")
    end
  end

  def delete
    match_id = url_params["match_id"]
    if match = Bingo.get_match(match_id)
      Bingo.delete_match(match)
    end

    render_json(nil)
  end
end
