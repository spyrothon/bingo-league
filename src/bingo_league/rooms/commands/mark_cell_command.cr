require "auto_initialize"

module Rooms::Commands
  struct MarkCell < BaseCommand
    include AutoInitialize

    property cell_index : Int32
    property team : String


    def self.from_params(params)
      cell_index = params["cell_index"].as_i
      team = params["team"].as_s

      new(cell_index: cell_index, team: team)
    end
  end
end
