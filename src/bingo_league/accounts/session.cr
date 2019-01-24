module BingoLeague::Accounts
  @[Crinja::Attributes]
  class Session < Crecto::Model
    schema "acc_sessions" do
      field :key, String
      field :valid, Bool, default: false

      belongs_to :user, User
    end
  end
end
