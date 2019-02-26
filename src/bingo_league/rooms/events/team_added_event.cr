require "../room_event"

module Rooms
  struct TeamAddedEvent < EventData
    JSON.mapping(
      team: String
    )
  end

  RoomEvent.register_type("team_added", TeamAddedEvent)
end
