require "./repo.cr"
require "crecto"

require "./rooms/*"


class Rooms::Context
  alias RoomID = Int64
  alias Repo = BingoLeague::Repo
  alias Query = BingoLeague::Query
  # In-memory cache of aggregates
  property rooms : Hash(RoomID, Room)

  def initialize
    @rooms = {} of RoomID => Room
  end

  # Return the Room with the given ID.
  #
  # Checks the in-memory cache first, otherwise builds the state back from
  # the stored events for that ID.
  def get_room(room_id : RoomID)
    if rooms.has_key?(room_id)
      rooms[room_id]
    else
      events = events_for_room(room_id)
      room = Room.from_events(room_id, events)
      update_cache(room_id, room)
      room
    end
  end

  def events_for_room(room_id)
    stored_events = Repo.all(RoomEventStore, Query.where(room_id: room_id))
    stored_events.map(&.to_event)
  end


  private def update_cache(room_id : RoomID, room : Room)
    rooms[room_id] = room
  end
end
