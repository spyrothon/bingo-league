require "../room_event"

module Rooms
  struct RoomCreatedEvent < EventData
    JSON.mapping(
      name: String
    )
  end

  RoomEvent.register_type("room_created", RoomCreatedEvent)
end
