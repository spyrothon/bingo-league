require "../../../bingo_league/rooms"

class BingoWeb::API::RoomsController < BingoWeb::Controller
  def index
    rooms = Rooms::Context.list_rooms
    render_json({
      rooms: rooms
    })
  end

  def show
    if room = get_room(url_params["room_id"])
      render_json({
        room: room
      })
    end
  end

  def create
    room_id = Random.rand(Int32::MAX).to_i64
    params = structured_params(Params::CreateRoom)
    name = params.name || "Room ##{room_id}"
    seed = params.seed || Random.rand(Int32::MAX)

    if room = Rooms::Context.create_room(room_id, name, seed)
      render_json({
        room: room
      })
    else
      render_error_json(422, "Could not create room")
    end
  end


  def mark_goal
    if room = get_room(url_params["room_id"])
      command = Rooms::Commands::MarkCell.from_params(json_params)
      Rooms::Context.process_and_save(room, command)
      render_json({
        data: :accepted
      })
    else
      render_error_json(404, "Room does not exist")
    end
  end

  def events
    if room_id = url_params["room_id"]?
      events = Rooms::Context.events_for_room(room_id)
      render_json({
        events: events
      })
    else
      render_error_json(404, "Room does not exist")
    end
  end


  private def get_room(id : String)
    if room_id = id.to_i?
      Rooms::Context.get_room(room_id.to_i64)
    else
      nil
    end
  end
end
