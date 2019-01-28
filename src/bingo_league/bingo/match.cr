require "crinja"

module BingoLeague::Bingo
  @[Crinja::Attributes]
  class Match < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_matches" do
      field :name, String
      field :start_date, Time

      field :description, String
      field :notes, String
      field :video_link, String

      has_many :plays, Play
      has_many :teams, Team, through: :plays
    end

    validate_required :name
  end
end
