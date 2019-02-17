require "../room_event"

module Rooms
  struct GoalMarkedEvent < EventData
    JSON.mapping(
      goal_idx: Int32,
      player: String
    )
  end

  RoomEvent.register_type("goal_marked", GoalMarkedEvent)
end
