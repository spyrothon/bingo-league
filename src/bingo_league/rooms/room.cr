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
    property players : Hash(Int64, User)
    property teams : Set(Team)
    property chat : Array(String)

    def initialize(@room_id : String, @version = 1_i64)
      @name = "Room #{@room_id}"
      @players = Hash(Int64, User).new
      @teams = Set(Team).new
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

    def do_process(command : Commands::AddTeam)
      name = command.name
      color = command.color
      meta = command.meta
      [
        Rooms::RoomEvent.team_added(room_id, name, color, meta)
      ]
    end

    def do_process(command : Commands::RemoveTeam)
      name = command.name
      meta = command.meta
      [
        Rooms::RoomEvent.team_removed(room_id, name, meta)
      ]
    end

    def do_process(command : Commands::JoinTeam)
      meta = command.meta
      player = meta[:user]
      player_id = meta[:user_id]
      player_existed = self.players.has_key?(player_id)
      existing_team = self.teams.find{ |t| t.player_ids.includes?(player_id) }.try(&.name)
      new_team = self.teams.find{ |t| t.name == command.team }
      events = [] of Rooms::RoomEvent

      unless player_existed
        events << Rooms::RoomEvent.player_added(room_id, player, meta)
      end

      return events unless new_team

      new_team = new_team.name

      if existing_team
        events << Rooms::RoomEvent.player_team_changed(room_id, player_id, existing_team, new_team, meta)
      else
        events << Rooms::RoomEvent.player_team_joined(room_id, player_id, new_team, meta)
      end

      events
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

    def do_apply(data : PlayerAddedEvent, meta)
      self.players[data.user_id] = data.user
    end

    def do_apply(data : PlayerRemovedEvent, meta)
      self.players.delete(data.user_id)
    end

    def do_apply(data : TeamAddedEvent, meta)
      team = Team.new(
        name: data.name,
        color: data.color
      )

      self.teams << team
    end

    def do_apply(data : TeamRemovedEvent, meta)
      if team = self.teams.find{ |t| t.name == data.name }
        self.teams.delete(team)
      end
    end

    def do_apply(data : PlayerTeamJoinedEvent, meta)
      player_id = data.player_id
      if team = self.teams.find{ |t| t.name == data.team }
        team.player_ids << player_id
      end
    end

    def do_apply(data : PlayerTeamChangedEvent, meta)
      player_id = data.player_id
      if old_team = self.teams.find{ |t| t.name == data.team }
        old_team.player_ids.delete(player_id)
      end
      if team = self.teams.find{ |t| t.name == data.team }
        team.player_ids << player_id
      end
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
  end
end
