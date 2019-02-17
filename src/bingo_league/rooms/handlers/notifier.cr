require "../../repo.cr"
require "crecto"

require "../event_handler.cr"


class Rooms::Notifier < Rooms::EventHandler
  def handle(event : RoomEvent)
    pp event
  end
end
