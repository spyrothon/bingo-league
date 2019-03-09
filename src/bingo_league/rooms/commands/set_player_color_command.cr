require "auto_initialize"

module Rooms::Commands
  struct SetPlayerColor < BaseCommand
    include AutoInitialize

    property user : BingoLeague::Accounts::User
    property color : String

    def self.from_params(params, user)
      color = params["color"].as_s

      new(user: user, color: color)
    end
  end
end
