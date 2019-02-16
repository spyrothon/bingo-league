require "json"

abstract struct EventData
end

struct RoomEvent
  JSON.mapping(
    type: String,
    room_id: Int64,
    data: String,
    timestamp: Time
  )

  EVENT_TYPES = {
    "unknown" => EventData
  }

  macro register_type(type, structure)
    {% EVENT_TYPES[type] = structure %}
  end


  def initialize(*, @type : String, @room_id : Int64, data, @timestamp=Time.utc_now())
    @data = data.to_json
  end

  @parsed_data : EventData?
  def data
    @parsed_data ||= EVENT_TYPES[@type].from_json(@data)
  end


  ###
  # Events
  ###

  def RoomEvent.room_created(room_id : Int64, board : Array(String), players : Array(String))
    new(
      type: "room_created",
      room_id: room_id,
      data: {
        board: board,
        players: players
      }
    )
  end

  def RoomEvent.board_changed(room_id : Int64, board : Array(String))
    new(
      type: "board_changed",
      room_id: room_id,
      data: {
        board: board
      }
    )
  end

  def RoomEvent.player_added(room_id : Int64, player : String)
    new(
      type: "player_added",
      room_id: room_id,
      data: {
        player: player
      }
    )
  end

  def RoomEvent.player_removed(room_id : Int64, player : String)
    new(
      type: "player_removed",
      room_id: room_id,
      data: {
        player: player
      }
    )
  end
end
