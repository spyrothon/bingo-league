require "../room_event"

module Rooms
  struct ChatMessageSentEvent < EventData
    JSON.mapping(
      content: String
    )
  end

  RoomEvent.register_type("chat_message_sent", ChatMessageSentEvent)
end
