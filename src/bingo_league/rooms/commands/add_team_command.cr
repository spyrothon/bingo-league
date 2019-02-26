require "auto_initialize"

module Rooms::Commands
  struct AddTeam < BaseCommand
    include AutoInitialize

    property team : String
  end
end
