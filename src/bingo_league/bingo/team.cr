require "crinja"

module Bingo
  @[Crinja::Attributes]
  class Team < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_teams" do
      field :name, String
      field :color, String

      belongs_to :league, League

      has_many :plays, Play
      has_many :players, Player, through: :plays
    end
  end
end
