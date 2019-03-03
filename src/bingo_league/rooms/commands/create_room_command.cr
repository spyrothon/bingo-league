require "auto_initialize"

module Rooms::Commands
  struct CreateRoom < BaseCommand
    include AutoInitialize

    property name : String
  end
end
