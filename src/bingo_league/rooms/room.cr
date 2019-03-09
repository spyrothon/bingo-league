require "../accounts"

require "./*"
require "./events/*"
require "./commands/*"


module Rooms
  struct Room # < Aggregate
    private alias User = BingoLeague::Accounts::User

    include JSON::Serializable
    property version : Int64
    property last_updated : Time
    property room_id : String
    property name : String
    property! owner : User?
    property! board : Board?
    property players : Hash(Int64, Player)
    property chat : Array(String)

    def initialize(@room_id : String, @version = 1_i64)
      @name = "Room #{@room_id}"
      @players = Hash(Int64, Player).new
      @last_updated = Time.new
      @chat = [] of String
    end

    def self.from_events(room_id : String, events)
      agg = self.new(room_id)
      events.reduce(agg){ |agg, event| agg.apply(event) }
    end



    ###
    # Processes
    ###

    def process(command : Commands::BaseCommand)
      events = do_process(command)
      events || [] of RoomEvent
    end

    def do_process(command : Commands::CreateRoom)
      name = command.name
      meta = command.meta
      [
        Rooms::RoomEvent.room_created(room_id, name, meta)
      ]
    end

    def do_process(command : Commands::UpdateBoard)
      new_board = command.board
      meta = command.meta
      [
        Rooms::RoomEvent.board_updated(room_id, new_board, meta)
      ]
    end

    def do_process(command : Commands::JoinRoom)
      meta = command.meta
      user = command.user
      nickname = command.nickname
      color = command.color || "#ffffff"
      player = Player.new(user: user, nickname: nickname, color: color)

      return nil if self.players[player.id]?
      [
        Rooms::RoomEvent.player_joined(room_id, player, meta)
      ]
    end

    def do_process(command : Commands::LeaveRoom)
      meta = command.meta
      user = command.user
      requested_player = requested_player_for_user(user)
      player = self.players[requested_player.id]?
      return nil unless player
      [
        Rooms::RoomEvent.player_left(room_id, player, meta)
      ]
    end

    def do_process(command : Commands::SetPlayerNickname)
      meta = command.meta
      user = command.user
      nickname = command.nickname
      requested_player = requested_player_for_user(user)
      player = self.players[requested_player.id]?
      return nil unless player
      [
        Rooms::RoomEvent.player_nickname_changed(room_id, player, nickname, meta)
      ]
    end

    def do_process(command : Commands::SetPlayerColor)
      meta = command.meta
      user = command.user
      color = command.color
      requested_player = requested_player_for_user(user)
      player = self.players[requested_player.id]?
      return nil unless player
      [
        Rooms::RoomEvent.player_color_changed(room_id, player, color, meta)
      ]
    end

    def do_process(command : Commands::MarkCell)
      cell_index = command.cell_index
      team = command.team
      meta = command.meta
      unless cell = board.cells[cell_index]?
        raise "Board does not have the requested cell"
      end
      [
        Rooms::RoomEvent.cell_marked(room_id, cell_index, cell, team, meta)
      ]
    end

    def do_process(command : Commands::UnmarkCell)
      cell_index = command.cell_index
      team = command.team
      meta = command.meta
      unless cell = board.cells[cell_index]?
        raise "Board does not have the requested cell"
      end
      [
        Rooms::RoomEvent.cell_unmarked(room_id, cell_index, cell, team, meta)
      ]
    end

    def do_process(command : Commands::SendChatMessage)
      content = command.content
      meta = command.meta
      [
        Rooms::RoomEvent.chat_message_sent(room_id, content, meta)
      ]
    end

    def do_process(command : Commands::BaseCommand)
      raise "Unknown command #{command}"
    end


    ###
    # Applications
    ###

    def apply(event : RoomEvent)
      do_apply(event.data, event.meta)
      self.version += 1
      self.last_updated = event.timestamp
      self
    end

    def do_apply(data : RoomCreatedEvent, meta)
      self.name = data.name
      self.owner = meta.user
    end

    def do_apply(data : BoardUpdatedEvent, meta)
      self.board = data.board
    end

    def do_apply(data : PlayerJoinedEvent, meta)
      player = data.player
      player_id = player.id
      self.players[player_id] = player
    end

    def do_apply(data : PlayerLeftEvent, meta)
      player = data.player
      player_id = player.id
      self.players.delete(player_id)
    end

    def do_apply(data : PlayerNicknameChanged, meta)
      player = data.player
      player_id = player.id
      nickname = data.nickname

      self.players[player_id].nickname = nickname
    end

    def do_apply(data : PlayerColorChanged, meta)
      player = data.player
      player_id = player.id
      color = data.color

      self.players[player_id].color = color
    end

    def do_apply(data : CellMarkedEvent, meta)
      cell_index = data.cell_index
      team = data.team

      cell = self.board.cells[cell_index]
      cell.marked_by << team
    end

    def do_apply(data : CellUnmarkedEvent, meta)
      cell_index = data.cell_index
      team = data.team

      cell = self.board.cells[cell_index]
      cell.marked_by.delete(team)
    end

    def do_apply(data : ChatMessageSentEvent, meta)
      message = data.content
      self.chat << message
    end



    ###
    # Utilities
    ###

    def requested_player_for_user(user : BingoLeague::Accounts::User)
      requested_player = Player.new(user: user, color: "#ffffff")
    end
  end
end
