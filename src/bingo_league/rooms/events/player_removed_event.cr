require "../room_event"

module Rooms
  struct PlayerRemovedEvent < EventData
    JSON.mapping(
      player: String
    )
  end

  RoomEvent.register_type("player_removed", PlayerRemovedEvent)
end
