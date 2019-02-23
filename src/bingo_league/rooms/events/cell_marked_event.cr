require "../room_event"

module Rooms
  struct CellMarkedEvent < EventData
    JSON.mapping(
      cell_index: Int32,
      player: String
    )
  end

  RoomEvent.register_type("cell_marked", CellMarkedEvent)
end
