require "../../../bingo_league/rooms"

class BingoWeb::API::RoomsController < BingoWeb::Controller
  def index
    rooms = Rooms::Context.list_rooms
    render_json({
      rooms: rooms
    })
  end

  def show
    if room = Rooms::Context.get_room(url_params["room_id"])
      render_json({
        room: room
      })
    end
  end


  ###
  # Commands
  ###

  def create
    room_id = Random::Secure.urlsafe_base64(8)
    params = structured_params(Params::CreateRoom)
    name = params.name || "Room ##{room_id}"
    seed = params.seed || Random.rand(Int32::MAX)

    if room = Rooms::Context.create_room(room_id, name, seed, @context.current_user)
      render_json({
        room: room
      })
    else
      render_error_json(422, "Could not create room")
    end
  end

  def join
    room_command(url_params["room_id"]) do |room|
      Rooms::Commands::JoinRoom.from_params(json_params, @context.current_user)
    end
  end

  def leave
    room_command(url_params["room_id"]) do |room|
      Rooms::Commands::LeaveRoom.from_params(json_params, @context.current_user)
    end
  end

  def mark_cell
    room_command(url_params["room_id"]) do |room|
      command = Rooms::Commands::MarkCell.from_params(json_params)
    end
  end

  def unmark_cell
    room_command(url_params["room_id"]) do |room|
      command = Rooms::Commands::UnmarkCell.from_params(json_params)
    end
  end

  def toggle_cell
    room_command(url_params["room_id"]) do |room|
      command = Rooms::Commands::ToggleCell.from_params(json_params)
    end
  end

  def set_nickname
    room_command(url_params["room_id"]) do |room|
      command = Rooms::Commands::SetPlayerNickname.from_params(json_params, @context.current_user)
    end
  end

  def set_color
    room_command(url_params["room_id"]) do |room|
      command = Rooms::Commands::SetPlayerColor.from_params(json_params, @context.current_user)
    end
  end

  def send_chat_message
    room_command(url_params["room_id"]) do |room|
      command = Rooms::Commands::SendChatMessage.from_params(json_params)
    end
  end

  private def room_command(room_id)
    if room = Rooms::Context.get_room(room_id)
      command = yield room
      command = set_meta(command)
      Rooms::Context.process_and_save(room, command)
      render_json({
        data: :accepted
      })
    else
      render_error_json(404, "Room does not exist")
    end
  end

  private def set_meta(command)
    command.with_meta(
      user: @context.current_user,
      user_id: @context.current_user.id
    )
  end
end
