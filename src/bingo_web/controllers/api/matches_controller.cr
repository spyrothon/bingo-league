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
    changeset = Bingo.create_match(json_params.as_h)

    unless changeset.valid?
      render_error_json(422, "Couldn't create match")
      return
    end

    match = changeset.instance

    plays_params = json_params["plays"].as_a
    plays_params = mark_winning_play(plays_params)

    plays_params.each do |play_params|
      Bingo.create_play(play_params.as_h)
    end

    match = Bingo.get_match(match.id)
    render_json({ match: match })
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

    changeset = Bingo.update_match(match, json_params.as_h)
    unless changeset.valid?
      render_error_json(422, "Couldn't update match")
      return
    end

    existing_plays = Bingo.list_plays(Query.where(match_id: match_id))
    existing_plays.each do |play|
      Bingo.delete_play(play)
    end

    plays_params = json_params["plays"].as_a
    plays_params = mark_winning_play(plays_params)
    plays_params.each do |play_params|
      Bingo.create_play(play_params.as_h)
    end

    match = changeset.instance
    match = Bingo.get_match(match.id)
    render_json({ match: match })
  end

  def delete
    match_id = url_params["match_id"]
    if match = Bingo.get_match(match_id)
      Bingo.delete_match(match)
    end

    render_json(nil)
  end


  # Wow this is bad. Setting after casting into a Schema would be better.
  private def mark_winning_play(plays_params)
    sorted_params = plays_params.sort_by do |params|
      if score = params["score"]?
        case raw = score.raw
        when String
          raw.to_i
        when Int
          raw
        else
          0
        end
      else
        0
      end
    end.reverse

    pp sorted_params
    sorted_params.each do |params|
      params.as_h["won"] = JSON::Any.new(false)
    end
    sorted_params[0].as_h["won"] = JSON::Any.new(true)
    sorted_params
  end
end
