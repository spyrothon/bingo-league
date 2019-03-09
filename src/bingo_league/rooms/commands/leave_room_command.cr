require "auto_initialize"

module Rooms::Commands
  struct LeaveRoom < BaseCommand
    include AutoInitialize

    property user : BingoLeague::Accounts::User

    def self.from_params(params, user)
      new(user: user)
    end
  end
end
