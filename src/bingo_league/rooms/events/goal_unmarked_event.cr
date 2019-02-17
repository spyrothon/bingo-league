require "../room_event"

module Rooms
  struct GoalUnmarkedEvent < EventData
    JSON.mapping(
      goal_idx: Int32,
      player: String
    )
  end

  RoomEvent.register_type("goal_unmarked", GoalUnmarkedEvent)
end
