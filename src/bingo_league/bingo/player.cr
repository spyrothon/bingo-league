require "crinja"

module Bingo
  @[Crinja::Attributes]
  class Player < Crecto::Model
    include Crinja::Object::Auto

    schema "bingo_players" do
      field :alias_name, String

      belongs_to :owner, Account
    end
  end
end
