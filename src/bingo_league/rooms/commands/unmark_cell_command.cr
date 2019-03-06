require "auto_initialize"

module Rooms::Commands
  struct UnmarkCell < BaseCommand
    include AutoInitialize

    property cell_index : Int32
    property team : String
    property player : String


    def self.from_params(params)
      cell_index = params["cell_index"].as_i
      team = params["team"].as_s
      player = params["player"].as_s

      new(cell_index: cell_index, team: team, player: player)
    end
  end
end
