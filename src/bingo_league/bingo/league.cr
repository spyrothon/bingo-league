require "crinja"

module Bingo
  @[Crinja::Attributes]
  class League < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_leagues" do
      field :name, String

      belongs_to :owner, Account

      has_many :matches, Match
      has_many :teams, Team
    end
  end
end
