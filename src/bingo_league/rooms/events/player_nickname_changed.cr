require "../room_event"
require "../player"

module Rooms
  struct PlayerNicknameChanged < EventData
    JSON.mapping(
      player: Player,
      old_nickname: String?,
      nickname: String
    )
  end

  RoomEvent.register_type("player_nickname_changed", PlayerNicknameChanged)
end
