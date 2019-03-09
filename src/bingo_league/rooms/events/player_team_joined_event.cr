require "../room_event"

module Rooms
  struct PlayerTeamJoinedEvent < EventData
    JSON.mapping(
      player_id: Int64,
      team: String
    )
  end

  RoomEvent.register_type("player_team_joined", PlayerTeamJoinedEvent)
end
