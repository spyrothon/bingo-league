module Rooms
  class RoomEventStore < Crecto::Model
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


    def to_event
      RoomEvent.new(
        room_id: self.room_id!,
        type: self.type!,
        data: self.data!,
        timestamp: self.timestamp!
      )
    end
  end
end
