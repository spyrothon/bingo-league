require "auto_initialize"

module Rooms::Commands
  struct MarkCell < BaseCommand
    include AutoInitialize

    property cell_index : Int32
    property player : String


    def self.from_params(params)
      cell_index = params["cell_index"].as_i
      player = params["player"].as_s

      new(cell_index: cell_index, player: player)
    end
  end
end
