require "auto_initialize"

module Rooms::Commands
  struct UnmarkGoal < BaseCommand
    include AutoInitialize

    property goal_idx : Int32
    property player : String
  end
end
