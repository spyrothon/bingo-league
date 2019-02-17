require "auto_initialize"
require "../board"

module Rooms::Commands
  struct UpdateBoard < BaseCommand
    include AutoInitialize

    property board : Board
  end
end
