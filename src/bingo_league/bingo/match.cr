require "crinja"

module Bingo
  @[Crinja::Attributes]
  class Match < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_matches" do
      field :name, String
      field :start_date, Time

      has_many :plays, Play
      has_many :players, Player, through: :plays
      has_many :teams, Team, through: :plays

      belongs_to :league, League
    end
  end
end
