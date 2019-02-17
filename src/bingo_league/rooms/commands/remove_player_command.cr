require "auto_initialize"

module Rooms::Commands
  struct RemovePlayer < BaseCommand
    include AutoInitialize

    property player : String
  end
end
