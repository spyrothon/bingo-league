require "auto_initialize"

require "../room_event"
require "../board"

module Rooms
  struct BoardUpdatedEvent < EventData
    JSON.mapping(
      board: Board
    )
  end

  RoomEvent.register_type("board_updated", BoardUpdatedEvent)
end
