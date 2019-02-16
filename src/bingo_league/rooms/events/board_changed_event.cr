require "../room_event"

module Rooms
  struct BoardChangedEvent < EventData
    JSON.mapping(
      board: Array(String)
    )
  end

  RoomEvent.register_type("board_changed", BoardChangedEvent)
end
