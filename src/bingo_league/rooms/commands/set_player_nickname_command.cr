require "auto_initialize"

module Rooms::Commands
  struct SetPlayerNickname < BaseCommand
    include AutoInitialize

    property user : BingoLeague::Accounts::User
    property nickname : String

    def self.from_params(params, user)
      nickname = params["nickname"].as_s

      new(user: user, nickname: nickname)
    end
  end
end
