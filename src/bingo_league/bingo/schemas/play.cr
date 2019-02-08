require "crinja"

module BingoLeague::Bingo
  @[JSON::Serializable::Options(emit_nulls: true)]
  @[Crinja::Attributes]
  class Play < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_plays" do
      field :score, Int32, default: 0
      field :won, Bool, default: false
      field :round, Int32, default: 1

      belongs_to :team, Team
      belongs_to :match, Match
    end

    validate_required :team_id
    validate_required :match_id
  end
end
