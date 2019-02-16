require "../room_event"

struct BoardChangedEvent < EventData
  JSON.mapping(
    board: Array(String)
  )
end

RoomEvent.register_type("board_changed", BoardChangedEvent)
