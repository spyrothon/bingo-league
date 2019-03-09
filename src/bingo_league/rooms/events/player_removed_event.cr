require "../room_event"

module Rooms
  struct PlayerRemovedEvent < EventData
    JSON.mapping(
      user: BingoLeague::Accounts::User,
      user_id: Int64
    )
  end

  RoomEvent.register_type("player_removed", PlayerRemovedEvent)
end
