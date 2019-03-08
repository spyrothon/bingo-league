require "auto_initialize"

module Rooms::Commands
  struct RemoveTeam < BaseCommand
    include AutoInitialize

    property team_id : String


    def self.from_params(params)
      team_id = params["team_id"].as_s

      new(team_id: team_id)
    end
  end
end
