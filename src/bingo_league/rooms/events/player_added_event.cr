require "../room_event"

module Rooms
  struct PlayerAddedEvent < EventData
    JSON.mapping(
      player: String
    )
  end

  RoomEvent.register_type("player_added", PlayerAddedEvent)
end
