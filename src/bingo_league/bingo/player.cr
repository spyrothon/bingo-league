require "crinja"
require "../accounts"

module BingoLeague::Bingo
  @[Crinja::Attributes]
  class Player < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_players" do
      field :alias_name, String

      belongs_to :account, Accounts::User, foreign_key: :account_id
    end

    def name
      alias_name || (account? && account.name)
    end
  end
end
