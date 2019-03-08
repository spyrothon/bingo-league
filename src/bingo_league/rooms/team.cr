require "json"
require "auto_initialize"

module Rooms
  class Team
    include AutoInitialize
    include JSON::Serializable

    property id : String
    property name : String
    property color : String
  end
end
