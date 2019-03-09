require "auto_initialize"

module Rooms::Commands
  struct JoinRoom < BaseCommand
    include AutoInitialize

    property user : BingoLeague::Accounts::User
    property nickname : String?
    property color : String?

    def self.from_params(params, user)
      nickname = params["nickname"]?.try(&.as_s)
      color = params["color"]?.try(&.as_s)

      new(user: user, nickname: nickname, color: color)
    end
  end
end
