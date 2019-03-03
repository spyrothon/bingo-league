require "auto_initialize"

class Rooms::Cell
  JSON.mapping(
    goal_id: Int64,
    goal: Goal,
    marked_by: Set(String)
  )

  def initialize(@goal, @marked_by = Set(String).new)
    @goal_id = @goal.id.as(Int).to_i64
  end
end
