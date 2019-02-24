require "../../../bingo_league/league"

class BingoWeb::API::MatchesController < BingoWeb::Controller
  private alias Query = BingoLeague::Query
  private alias League = BingoLeague::League

  def index
    matches = League.list_matches(
      Query.where(is_public: "true").order_by("start_date ASC")
    )
    render_json({
      matches: matches
    })
  end

  def show
    match = League.get_match(url_params["match_id"])
    render_json({ match: match })
  end

  def new
    match = League.new_match()
    render_json({ match: match })
  end

  def create
    changeset = League.create_match(json_params.as_h)

    unless changeset.valid?
      render_error_json(422, "Couldn't create match")
      return
    end

    match = changeset.instance

    plays_params = json_params["plays"].as_a
    plays_params = mark_winning_play(plays_params)

    plays_params.each do |play_params|
      play_params = play_params.as_h
      play_params["match_id"] = JSON::Any.new(match.id.to_s)
      League.create_play(play_params)
    end

    match = League.get_match(match.id)
    render_json({ match: match })
  end

  def edit
    match = League.get_match(url_params["match_id"])

    if match
      render_json({ match: match })
    else
      render_error_json(404, "Couldn't find match")
    end
  end

  def update
    match_id = url_params["match_id"]
    unless match = League.get_match(match_id)
      render_error_json(404, "Couldn't find match")
      return
    end

    changeset = League.update_match(match, json_params.as_h)
    unless changeset.valid?
      render_error_json(422, "Couldn't update match")
      return
    end

    existing_plays = League.list_plays(Query.where(match_id: match_id))
    existing_plays.each do |play|
      League.delete_play(play)
    end

    plays_params = json_params["plays"].as_a
    plays_params = mark_winning_play(plays_params)
    plays_params.each do |play_params|
      League.create_play(play_params.as_h)
    end

    match = changeset.instance
    match = League.get_match(match.id)
    render_json({ match: match })
  end

  def delete
    match_id = url_params["match_id"]
    if match = League.get_match(match_id)
      League.delete_match(match)
    end

    render_json(nil)
  end


  # Wow this is bad. Setting after casting into a Schema would be better.
  private def mark_winning_play(plays_params)
    sorted_params = plays_params.sort_by do |params|
      if score = params["score"]?
        case raw = score.raw
        when String
          raw.empty? ? raw.to_i : 0
        when Int
          raw
        else
          0
        end
      else
        0
      end
    end.reverse

    sorted_params.each do |params|
      params.as_h["won"] = JSON::Any.new(false)
    end
    if winner = sorted_params[0]?
      winner.as_h["won"] = JSON::Any.new(true)
    end
    sorted_params
  end
end
