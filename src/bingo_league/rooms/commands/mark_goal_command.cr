require "auto_initialize"

module Rooms::Commands
  struct MarkGoal < BaseCommand
    include AutoInitialize

    property goal_idx : Int32
    property player : String
  end
end
