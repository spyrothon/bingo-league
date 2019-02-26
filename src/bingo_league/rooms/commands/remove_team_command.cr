require "auto_initialize"

module Rooms::Commands
  struct RemoveTeam < BaseCommand
    include AutoInitialize

    property team : String
  end
end
