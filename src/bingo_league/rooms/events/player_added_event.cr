require "../room_event"

struct PlayerAddedEvent < EventData
  JSON.mapping(
    player: String
  )
end

RoomEvent.register_type("player_added", PlayerAddedEvent)
