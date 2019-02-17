require "./*"
require "./events/*"
require "./commands/*"

module Rooms
  struct Room # < Aggregate
    property version : Int64
    property room_id : Int64
    property name : String
    property board : Board
    property players : Set(String)

    def initialize(@room_id : Int64, @version = 1_i64)
      @name = "Room #{@room_id}"
      @board = Board.new
      @players = Set(String).new
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

    def do_process(command : Commands::MarkGoal)
      goal_idx = command.goal_idx
      player = command.player
      unless goal = board.goals[goal_idx]?
        raise "Board does not have the requested goal"
      end
      [
        Rooms::RoomEvent.goal_marked(room_id, goal_idx, player)
      ]
    end

    def do_process(command : Commands::UnmarkGoal)
      goal_idx = command.goal_idx
      player = command.player
      unless board.goals[goal_idx]?
        raise "Board does not have the requested goal"
      end
      [
        Rooms::RoomEvent.goal_unmarked(room_id, goal_idx, player)
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

    def do_apply(data : GoalMarkedEvent)
      goal_idx = data.goal_idx
      player = data.player

      goal = self.board.goals[goal_idx]
      goal.marked_by << player
    end

    def do_apply(data : GoalUnmarkedEvent)
      goal_idx = data.goal_idx
      player = data.player

      goal = self.board.goals[goal_idx]
      goal.marked_by.delete(player)
    end
  end
end
