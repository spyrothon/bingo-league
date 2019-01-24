require "crinja"

module BingoLeague::Bingo
  @[Crinja::Attributes]
  class Play < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_plays" do
      field :score, Int32

      belongs_to :player, Player
      belongs_to :team, Team
      belongs_to :match, Match
    end
  end
end
