record BingoRooms::Cell,
    name : String,
    child : String? = nil,
    boardtypes : String? = nil,
    difficulty = 4, #1..25
    synergy = 0,
    types = [] of String do
  include JSON::Serializable
end
