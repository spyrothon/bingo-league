require "./*"
require "./events/*"
require "./commands/*"

module Rooms
  struct Room # < Aggregate
    include JSON::Serializable
    property version : Int64
    property last_updated : Time
    property room_id : Int64
    property name : String
    property board : Board
    property players : Set(String)
    property teams : Set(String)

    def initialize(@room_id : Int64, @version = 1_i64)
      @name = "Room #{@room_id}"
      @board = Board.new
      @players = Set(String).new
      @teams = Set(String).new
      @last_updated = Time.new
    end

    def self.from_events(room_id, events)
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
      [
        Rooms::RoomEvent.room_created(room_id, name)
      ]
    end

    def do_process(command : Commands::UpdateBoard)
      new_board = command.board
      [
        Rooms::RoomEvent.board_updated(room_id, new_board)
      ]
    end

    def do_process(command : Commands::AddPlayer)
      player = command.player
      return nil if self.players.includes?(player)
      [
        Rooms::RoomEvent.player_added(room_id, player)
      ]
    end

    def do_process(command : Commands::RemovePlayer)
      player = command.player
      return nil unless self.players.includes?(player)
      [
        Rooms::RoomEvent.player_removed(room_id, player)
      ]
    end

    def do_process(command : Commands::AddTeam)
      team = command.team
      return nil if self.teams.includes?(team)
      [
        Rooms::RoomEvent.team_added(room_id, team)
      ]
    end

    def do_process(command : Commands::RemoveTeam)
      team = command.team
      return nil unless self.teams.includes?(team)
      [
        Rooms::RoomEvent.team_removed(room_id, team)
      ]
    end

    def do_process(command : Commands::MarkCell)
      cell_index = command.cell_index
      team = command.team
      player = command.player
      unless cell = board.cells[cell_index]?
        raise "Board does not have the requested cell"
      end
      [
        Rooms::RoomEvent.cell_marked(room_id, cell_index, team, player)
      ]
    end

    def do_process(command : Commands::UnmarkCell)
      cell_index = command.cell_index
      team = command.team
      player = command.player
      unless board.cells[cell_index]?
        raise "Board does not have the requested cell"
      end
      [
        Rooms::RoomEvent.cell_unmarked(room_id, cell_index, team, player)
      ]
    end

    def do_process(command : Commands::BaseCommand)
      raise "Unknown command #{command}"
    end


    ###
    # Applications
    ###

    def apply(event : RoomEvent)
      do_apply(event.data)
      self.version += 1
      self.last_updated = event.timestamp
      self
    end

    def do_apply(data : RoomCreatedEvent)
      self.name = data.name
    end

    def do_apply(data : BoardUpdatedEvent)
      self.board = data.board
    end

    def do_apply(data : PlayerAddedEvent)
      self.players << data.player
    end

    def do_apply(data : PlayerRemovedEvent)
      self.players.delete(data.player)
    end

    def do_apply(data : TeamAddedEvent)
      self.teams << data.team
    end

    def do_apply(data : TeamRemovedEvent)
      self.teams.delete(data.team)
    end

    def do_apply(data : CellMarkedEvent)
      cell_index = data.cell_index
      player = data.player

      cell = self.board.cells[cell_index]
      cell.marked_by << player
    end

    def do_apply(data : CellUnmarkedEvent)
      cell_index = data.cell_index
      player = data.player

      cell = self.board.cells[cell_index]
      cell.marked_by.delete(player)
    end
  end
end
