require "./rooms/*"
require "./rooms/events/*"

struct RoomAggregate
  property version : Int64
  property id : Int64
  property board : Array(String)?
  property players : Array(String)

  def initialize(@id : Int64, @version = 1_i64)
    @board = nil
    @players = [] of String
  end

  def self.from_events(room_id, events)
    agg = self.new(room_id)
    events.reduce(agg){ |agg, event| agg.apply(event) }
  end

  def apply(event : RoomEvent)
    do_apply(event.data)
    self.version += 1
    self
  end

  def do_apply(data : RoomCreatedEvent)
    self.board = data.board
  end

  def do_apply(data : BoardChangedEvent)
    self.board = data.board
  end

  def do_apply(data : PlayerAddedEvent)
    self.players << data.player
  end
end
