require "../room_event"
require "../player"

module Rooms
  struct PlayerLeftEvent < EventData
    JSON.mapping(
      player: Player
    )
  end

  RoomEvent.register_type("player_left", PlayerLeftEvent)
end
