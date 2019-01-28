require "crinja"
require "../accounts"

module BingoLeague::Bingo
  @[JSON::Serializable::Options(emit_nulls: true)]
  @[Crinja::Attributes]
  class Player < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_players" do
      field :alias_name, String

      belongs_to :account, Accounts::User, foreign_key: :account_id
      belongs_to :team, Team
    end

    validate_required :account_id
    validate_required :team_id

    def name
      alias_name || (account? && account.name)
    end
  end
end
