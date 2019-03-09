require "../room_event"

module Rooms
  struct TeamAddedEvent < EventData
    JSON.mapping(
      name: String,
      color: String
    )
  end

  RoomEvent.register_type("team_added", TeamAddedEvent)
end
