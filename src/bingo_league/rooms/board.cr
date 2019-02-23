require "auto_initialize"

require "./cell.cr"

class Rooms::Board
  JSON.mapping(
    cells: Array(Cell)
  )

  def initialize(@cells = [] of Cell)
  end
end
