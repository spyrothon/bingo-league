require "json"

module Rooms
  class StorableEvent < Crecto::Model
    schema "room_events" do
      field :room_id, Int64
      field :type, String
      field :data, String

      field :timestamp, Time
      set_created_at_field nil
      set_updated_at_field nil
    end

    validate_required :type
    validate_required :room_id
    validate_required :data

    def self.from_event(event : RoomEvent)
      storage = self.new
      storage.room_id   = event.room_id
      storage.type      = event.type
      storage.data      = event.raw_data
      storage.timestamp = event.timestamp
      storage
    end

    def to_event
      room_id = self.room_id.not_nil!.to_i64
      RoomEvent.new(
        room_id: room_id,
        type: self.type!,
        data: self.data!,
        timestamp: self.timestamp!
      )
    end
  end
end
