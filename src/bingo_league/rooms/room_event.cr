require "json"

require "./board"
require "./cell"


module Rooms
  abstract struct EventData
  end

  struct EventMeta
    JSON.mapping(
      user: BingoLeague::Accounts::User,
      user_id: Int64
    )
  end

  struct RoomEvent
    JSON.mapping(
      type: String,
      room_id: String,
      raw_data: String,
      raw_meta: String,
      timestamp: Time
    )

    EVENT_TYPES = {
      "unknown" => EventData
    }

    macro register_type(type, structure)
      {% EVENT_TYPES[type] = structure %}
    end

    def initialize(*, @type : String, @room_id : String, data, meta, @timestamp=Time.utc_now())
      @raw_data =
        case data
        when String
          data
        else
          data.to_json
        end

      @raw_meta =
        case meta
        when String
          meta
        else
          meta.to_json
        end
    end

    @parsed_data : EventData?
    def data
      @parsed_data ||= EVENT_TYPES[@type].from_json(@raw_data)
    end

    @parsed_meta : EventMeta?
    def meta
      @parsed_meta ||= EventMeta.from_json(@raw_meta)
    end


    ###
    # Events
    ###

    def RoomEvent.room_created(room_id : String, name : String, meta)
      new(
        type: "room_created",
        room_id: room_id,
        data: {
          name: name
        },
        meta: meta
      )
    end

    def RoomEvent.board_updated(room_id : String, board : Board, meta)
      new(
        type: "board_updated",
        room_id: room_id,
        data: {
          board: board
        },
        meta: meta
      )
    end

    def RoomEvent.player_added(room_id : String, player : String, meta)
      new(
        type: "player_added",
        room_id: room_id,
        data: {
          player: player
        },
        meta: meta
      )
    end

    def RoomEvent.player_removed(room_id : String, player : String, meta)
      new(
        type: "player_removed",
        room_id: room_id,
        data: {
          player: player
        },
        meta: meta
      )
    end

    def RoomEvent.team_added(room_id : String, team : String, meta)
      new(
        type: "team_added",
        room_id: room_id,
        data: {
          team: team
        },
        meta: meta
      )
    end

    def RoomEvent.team_removed(room_id : String, team : String, meta)
      new(
        type: "team_removed",
        room_id: room_id,
        data: {
          team: team
        },
        meta: meta
      )
    end

    def RoomEvent.cell_marked(room_id : String, cell_index : Int32, cell : Cell, team : String, meta)
      new(
        type: "cell_marked",
        room_id: room_id,
        data: {
          cell_index: cell_index,
          cell: cell,
          team: team,
        },
        meta: meta
      )
    end

    def RoomEvent.cell_unmarked(room_id : String, cell_index : Int32, cell : Cell, team : String, meta)
      new(
        type: "cell_unmarked",
        room_id: room_id,
        data: {
          cell_index: cell_index,
          cell: cell,
          team: team
        },
        meta: meta
      )
    end
  end
end
