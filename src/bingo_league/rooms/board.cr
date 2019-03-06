require "auto_initialize"

require "./cell.cr"

class Rooms::Board
  JSON.mapping(
    size: Int32,
    seed: String,
    cells: Array(Cell)
  )

  def initialize(@size : Int32, seed, @cells = [] of Cell)
    @seed = seed.to_s
  end
end
