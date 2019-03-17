require "json"
require "auto_initialize"

module Rooms
  class Player
    include JSON::Serializable

    property  user : BingoLeague::Accounts::User
    property  color : String
    property! nickname : String?

    def initialize(*, @user : BingoLeague::Accounts::User, nickname = nil, @color = "#ffffff")
      @nickname = nickname || user.name
    end


    def nickname
      @nickname || user.name
    end

    def nickname=(new_nickname)
      @nickname = new_nickname || user.name
    end

    def id
      user.id.to_s.to_i64
    end
  end
end
