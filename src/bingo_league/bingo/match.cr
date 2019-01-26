require "crinja"

module BingoLeague::Bingo
  @[Crinja::Attributes]
  class Match < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_matches" do
      field :name, String
      field :start_date, Time

      has_many :plays, Play
      has_many :teams, Team, through: :plays

      belongs_to :league, League
    end

    validate_required :name
    validate_required :league_id
  end
end
