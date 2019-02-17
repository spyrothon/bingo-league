require "auto_initialize"

require "./goal.cr"

class Rooms::Board
  JSON.mapping(
    goals: Array(Goal)
  )

  def initialize(@goals = [] of Goal)
  end
end
