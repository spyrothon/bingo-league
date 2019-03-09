require "auto_initialize"

module Rooms::Commands
  struct MarkCell < BaseCommand
    include AutoInitialize

    property cell_index : Int32


    def self.from_params(params)
      cell_index = params["cell_index"].as_i

      new(cell_index: cell_index)
    end
  end
end
