require "../room_event"

module Rooms
  struct PlayerTeamChangedEvent < EventData
    JSON.mapping(
      player_id: Int64,
      old_team: String?,
      team: String
    )
  end

  RoomEvent.register_type("player_team_changed", PlayerTeamChangedEvent)
end
