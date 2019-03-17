require "auto_initialize"

class Rooms::Cell
  struct Marking
    JSON.mapping(
      color: String,
      player_id: Int64
    )

    def initialize(@color : String, @player_id : Int64)
    end
  end

  JSON.mapping(
    goal_id: Int64,
    goal: Goal,
    marked_by: Set(Marking)
  )

  def initialize(@goal : Goal, @marked_by = Set(Marking).new)
    @goal_id = @goal.id
  end

  def mark(color : String, player_id : Int64)
    marked_by.add(Marking.new(color: color, player_id: player_id))
  end

  def unmark(*, color : String)
    self.marked_by = Set.new(marked_by.reject{ |m| m.color == color })
  end

  def unmark(*, player id : Int64)
    self.marked_by = Set.new(marked_by.reject{ |m| m.player_id == id })
  end

  def marked_by_player?(player_id : Int64)
    self.marked_by.any?{ |m| m.player_id == player_id }
  end
end
