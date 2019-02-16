require "../room_event"

struct RoomCreatedEvent < EventData
  JSON.mapping(
    name: String
  )
end

RoomEvent.register_type("room_created", RoomCreatedEvent)
