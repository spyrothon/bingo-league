require "json"

module Rooms
  module Commands
    abstract struct BaseCommand
      property! meta : NamedTuple(user: BingoLeague::Accounts::User, user_id: Int64)?

      def with_meta(user : BingoLeague::Accounts::User, user_id)
        user_id = user_id.to_s.to_i64
        self.meta = {user: user, user_id: user_id}
        self
      end
    end
  end
end
