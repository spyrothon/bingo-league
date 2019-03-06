require "auto_initialize"

module Rooms::Commands
  struct RemovePlayer < BaseCommand
    include AutoInitialize

    property team : String
    property player : String


    def self.from_params(params)
      player = params["player"].as_s
      team = params["team"].as_s

      new(team: team, player: player)
    end
  end
end
