require "auto_initialize"

module Rooms::Commands
  struct AddPlayer < BaseCommand
    include AutoInitialize

    property player : String
  end
end
