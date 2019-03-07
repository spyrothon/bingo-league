require "json"
require "crecto"

module Rooms
  class StorableEvent < Crecto::Model
    schema "room_events" do
      field :room_id, String
      field :type, String
      field :data, String
      field :meta, String

      field :timestamp, Time
      set_created_at_field nil
      set_updated_at_field nil
    end

    validate_required :type
    validate_required :room_id
    validate_required :data
    validate_required :meta

    def self.from_event(event : RoomEvent)
      storage = self.new
      storage.room_id   = event.room_id
      storage.type      = event.type
      storage.data      = event.raw_data
      storage.meta      = event.raw_meta
      storage.timestamp = event.timestamp
      storage
    end

    def to_event
      RoomEvent.new(
        room_id: self.room_id!,
        type: self.type!,
        data: self.data!,
        meta: self.meta,
        timestamp: self.timestamp!
      )
    end
  end
end
