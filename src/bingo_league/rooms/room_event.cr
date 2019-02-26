require "json"

require "./board"


module Rooms
  abstract struct EventData
  end

  struct RoomEvent
    JSON.mapping(
      type: String,
      room_id: Int64,
      raw_data: String,
      timestamp: Time
    )

    EVENT_TYPES = {
      "unknown" => EventData
    }

    macro register_type(type, structure)
      {% EVENT_TYPES[type] = structure %}
    end

    def initialize(*, @type : String, @room_id : Int64, data, @timestamp=Time.utc_now())
      @raw_data =
        case data
        when String
          data
        else
          data.to_json
        end
    end

    @parsed_data : EventData?
    def data
      @parsed_data ||= EVENT_TYPES[@type].from_json(@raw_data)
    end

    def room_id : Int64
      @room_id.as(Int64)
    end


    ###
    # Events
    ###

    def RoomEvent.room_created(room_id : Int64, name : String)
      new(
        type: "room_created",
        room_id: room_id,
        data: {
          name: name
        }
      )
    end

    def RoomEvent.board_updated(room_id : Int64, board : Board)
      new(
        type: "board_updated",
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

    def RoomEvent.cell_marked(room_id : Int64, cell_index : Int32, team : String, player : String)
      new(
        type: "cell_marked",
        room_id: room_id,
        data: {
          cell_index: cell_index,
          team: team,
          player: player,
        }
      )
    end

    def RoomEvent.cell_unmarked(room_id : Int64, cell_index : Int32, team : String, player : String)
      new(
        type: "cell_unmarked",
        room_id: room_id,
        data: {
          cell_index: cell_index,
          team: team,
          player: player
        }
      )
    end
  end
end
