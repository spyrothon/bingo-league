require "../room_event"

struct RoomCreatedEvent < EventData
  JSON.mapping(
    board: Array(String),
    players: Array(String)
  )
end

RoomEvent.register_type("room_created", RoomCreatedEvent)
