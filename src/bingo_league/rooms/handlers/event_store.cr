require "../../repo.cr"
require "crecto"

require "../event_handler.cr"


class Rooms::EventStore < Rooms::EventHandler
  alias Repo = BingoLeague::Repo
  alias Query = BingoLeague::Query

  ###
  # Handlers
  ###

  def handle(event : RoomEvent)
    storable = StorableEvent.from_event(event)
    # TODO: Broken seemingly because we're running in a separate Fiber. Very
    # unsure of how to fix.
    #
    # UPDATE: Seems to be working with multiple command types. Not sure why,
    # probably not stable.
    Repo.insert(storable)
  end
end
