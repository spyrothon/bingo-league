require "../../../bingo_league/rooms"

class BingoWeb::API::RoomsController < BingoWeb::Controller
  def index
    rooms = Rooms::Context.list_rooms
    render_json({
      rooms: rooms
    })
  end
end
