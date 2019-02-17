require "./repo.cr"
require "crecto"

require "./rooms/*"
require "./rooms/handlers/*"


class Rooms::Context
  alias RoomID = Int64
  alias Repo = BingoLeague::Repo
  alias Query = BingoLeague::Query

  # Central bus for propogating events
  property event_bus : EventBus
  # In-memory cache of aggregates
  property cache : Cache
  property event_store : EventStore
  property workers : Array(Fiber)

  def initialize
    @event_bus = EventBus.new
    @workers = [] of Fiber
    @cache = Cache.new(event_bus)
    @event_store = EventStore.new(event_bus)
    @workers = start_workers([cache, event_store])
  end

  def start_workers(workers) : Array(Fiber)
    workers.map do |worker|
      spawn{ worker.start }
    end
  end

  # Return the Room with the given ID.
  #
  # Checks the in-memory cache first, otherwise builds the state back from
  # the stored events for that ID.
  def get_room(room_id : RoomID)
    if room = cache[room_id]?
      room
    else
      events = events_for_room(room_id)
      room = Room.from_events(room_id, events)
      update_cache(room_id, room)
      room
    end
  end

  def events_for_room(room_id)
    stored_events = Repo.all(StorableEvent, Query.where(room_id: room_id))
    stored_events.map(&.to_event)
  end


  def emit(events : Array(RoomEvent))
    events.each do |event|
      event_bus.publish(event)
    end
  end

  private def update_cache(room_id, room)
    cache.manual_update(room_id, room)
  end
end
