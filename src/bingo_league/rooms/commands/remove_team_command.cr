require "auto_initialize"

module Rooms::Commands
  struct RemoveTeam < BaseCommand
    include AutoInitialize

    property team : String


    def self.from_params(params)
      team = params["team"].as_s

      new(team: team)
    end
  end
end
