require "../room_event"

module Rooms
  struct TeamRemovedEvent < EventData
    JSON.mapping(
      team_id: String
    )
  end

  RoomEvent.register_type("team_removed", TeamRemovedEvent)
end
