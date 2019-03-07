require "crypto/bcrypt/password"

module BingoLeague::Accounts
  @[Crinja::Attributes]
  class User < Crecto::Model
    include Crinja::Object::Auto
    include JSON::Serializable

    schema "acc_users" do
      field :name, String
      field :discord, String
      field :twitch, String
      field :twitter, String
      field :timezone, String
      field :admin, Bool
      field :avatar_object_id, String

      @[Crinja::Attribute(ignore: true)]
      @[JSON::Field(ignore: true)]
      field :password, String, virtual: true
      @[Crinja::Attribute(ignore: true)]
      @[JSON::Field(ignore: true)]
      field :encrypted_password, String
    end


    validate_required :name
    validate_required :password


    def password=(new_password : String)
      @encrypted_password = Crypto::Bcrypt::Password.create(new_password).to_s
      @password = new_password
    end

    def password_matches?(other_password : String)
      Crypto::Bcrypt::Password.new(@encrypted_password.not_nil!) == other_password
    end
  end
end
