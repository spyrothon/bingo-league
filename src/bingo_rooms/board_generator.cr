
module BingoRooms::BoardGenerator
  extend self

  def generate(size : Int32 = 5)
    cells =
      Array.new(size*size) do |i|
        Cell.new("Cell #{i}")
      end

    Board.new(cells)
  end
end
