require "../room_event"
require "../player"

module Rooms
  struct PlayerColorChanged < EventData
    JSON.mapping(
      player: Player,
      old_color: String?,
      color: String
    )
  end

  RoomEvent.register_type("player_color_changed", PlayerColorChanged)
end
