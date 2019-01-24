require "crinja"
require "../accounts"

module BingoLeague::Bingo
  @[Crinja::Attributes]
  class League < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_leagues" do
      field :name, String

      belongs_to :owner, Accounts::User, foreign_key: :owner_id

      has_many :matches, Match
      has_many :teams, Team
    end
  end
end
