require "auto_initialize"

module Rooms::Commands
  struct UnmarkCell < BaseCommand
    include AutoInitialize

    property cell_index : Int32
    property player : String
  end
end
