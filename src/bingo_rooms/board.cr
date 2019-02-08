require "./cell"

class BingoRooms::Board
  include JSON::Serializable
  property cells : Array(Cell)

  def initialize(@cells : Array(Cell))
  end
end
