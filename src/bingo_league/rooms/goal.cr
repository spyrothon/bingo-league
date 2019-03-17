require "crecto"
require "crinja"

module Rooms
  @[Crinja::Attributes]
  class Goal < Crecto::Model
    include Crinja::Object::Auto

    schema "room_goals" do
      field :name, String
      field :clarification, String
      field :difficulty, Int32
      field :types, String
    end

    def id : Int64
      @id.as(Int).to_i64
    end
  end
end
