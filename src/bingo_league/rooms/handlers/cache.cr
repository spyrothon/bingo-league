require "../event_handler.cr"

class Rooms::Cache < Rooms::EventHandler
  property rooms = Hash(Int64, Room).new

  ###
  # Accessors
  ###

  delegate :[], :[]?, to: rooms

  def manual_update(room_id : Int64, room : Room)
    rooms[room_id] = room
  end



  ###
  # Handlers
  ###

  def handle(event : RoomEvent)
    # New state
    room_id = event.room_id
    room = rooms[room_id].apply(event)
    # Update cache
    rooms[room_id] = room
  end
end
