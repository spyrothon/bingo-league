require "crinja"

module BingoLeague::League
  @[JSON::Serializable::Options(emit_nulls: true)]
  @[Crinja::Attributes]
  class Team < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_teams" do
      field :name, String
      field :color, String

      has_many :plays, Play
      has_many :players, Player
      has_many :matches, Match, through: :plays
    end

    validate_required :name
  end
end
