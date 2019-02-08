require "../../../bingo_rooms/room_manager.cr"

class BingoWeb::API::RoomsController < BingoWeb::Controller
  def index
    rooms = BingoRooms::RoomManager.list_rooms()
    render_json({
      rooms: rooms
    })
  end

  def show
    room_id = url_params["room_id"]
    room = BingoRooms::RoomManager.get_room(room_id)
    render_json({
      room: room
    })
  end

  def create
    room = BingoRooms::RoomManager.create_room("asfl;kafs")
    render_json({
      room: room
    })
  end
end
