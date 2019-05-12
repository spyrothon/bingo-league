require "auto_initialize"
require "../board"

module Rooms::Commands
  struct UpdateBoard < BaseCommand
    include AutoInitialize

    property board : Board

    def self.from_params(board : Board)
      new(board: board)
    end
  end
end
