require "crinja"

module BingoLeague::League
  @[JSON::Serializable::Options(emit_nulls: true)]
  @[Crinja::Attributes]
  class Match < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_matches" do
      field :name, String
      field :start_date, Time

      field :description, String
      field :notes, String
      field :video_link, String
      field :room_link, String
      field :board_image_link, String

      field :is_featured, Bool, default: false
      field :is_finalized, Bool, default: false
      field :is_public, Bool, default: true

      has_many :plays, Play
      has_many :teams, Team, through: :plays
    end

    validate_required :name
  end
end
