require "auto_initialize"

module Rooms::Commands
  struct AddTeam < BaseCommand
    include AutoInitialize

    property name : String
    property color : String


    def self.from_params(params)
      name = params["name"].as_s
      color = params["color"].as_s

      new(name: name, color: color)
    end
  end
end
