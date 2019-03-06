require "../../repo.cr"
require "crecto"

require "../event_handler.cr"

require "../../../bingo_web/sockets/socket_supervisor"


class Rooms::Notifier < Rooms::EventHandler
  def handle(event : RoomEvent)
    room_id = event.room_id
    room = Rooms::Context.get_room(event.room_id)

    BingoWeb::SocketSupervisor.broadcast(room_id.to_s, {
      type: "room_update",
      room: room,
      events: [event]
    })
  end
end
