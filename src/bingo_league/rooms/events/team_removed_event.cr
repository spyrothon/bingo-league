require "../room_event"

module Rooms
  struct TeamRemovedEvent < EventData
    JSON.mapping(
      name: String
    )
  end

  RoomEvent.register_type("team_removed", TeamRemovedEvent)
end
