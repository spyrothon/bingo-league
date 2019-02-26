require "auto_initialize"

class Rooms::Cell
  JSON.mapping(
    goal_id: Int32,
    marked_by: Set(String)
  )

  def initialize(@goal_id, @marked_by = Set(String).new)
  end
end
