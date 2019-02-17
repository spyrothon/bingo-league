require "auto_initialize"

module Rooms::Commands
  struct GenerateBoard < BaseCommand
    include AutoInitialize

    property board : Array(String)
  end
end
