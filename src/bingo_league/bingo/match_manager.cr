require "./match_state"
require "honcho"

module BingoLeague::Bingo
  class MatchManager
    def initializer
      visor = Honcho::Visor.new(strategy: Honcho::Strategy::ISOLATED)
    end

    def create_match

    end
  end
end
