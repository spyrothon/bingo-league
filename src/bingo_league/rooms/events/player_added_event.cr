require "../room_event"

module Rooms
  struct PlayerAddedEvent < EventData
    JSON.mapping(
      user: BingoLeague::Accounts::User,
      user_id: Int64
    )
  end

  RoomEvent.register_type("player_added", PlayerAddedEvent)
end
