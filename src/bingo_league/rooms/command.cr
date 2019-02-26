require "json"

module Rooms
  module Commands
    abstract struct BaseCommand
      property! user : String

      def with_meta(@user : String)
      end
    end
  end
end
