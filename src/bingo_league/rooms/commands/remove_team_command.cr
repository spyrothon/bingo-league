require "auto_initialize"

module Rooms::Commands
  struct RemoveTeam < BaseCommand
    include AutoInitialize

    property name : String


    def self.from_params(params)
      name = params["name"].as_s

      new(name: name)
    end
  end
end
