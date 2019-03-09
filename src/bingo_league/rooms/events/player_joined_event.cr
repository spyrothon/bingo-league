require "../room_event"
require "../player"

module Rooms
  struct PlayerJoinedEvent < EventData
    JSON.mapping(
      player: Player
    )
  end

  RoomEvent.register_type("player_joined", PlayerJoinedEvent)
end
