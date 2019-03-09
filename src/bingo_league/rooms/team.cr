require "json"
require "auto_initialize"

module Rooms
  class Team
    include AutoInitialize
    include JSON::Serializable

    property name : String
    property color : String
    property player_ids = [] of Int64
  end
end
