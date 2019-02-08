require "./board"

class BingoRooms::Room
  include JSON::Serializable
  property id : String
  property name : String
  property board : Board
  property players : Array(String)

  def initialize(@id : String, @name : String, @board : Board, @players = [] of String)
  end
end
