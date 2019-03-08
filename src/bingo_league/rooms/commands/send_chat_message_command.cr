require "auto_initialize"

module Rooms::Commands
  struct SendChatMessage < BaseCommand
    include AutoInitialize

    property content : String


    def self.from_params(params)
      content = params["content"].as_s

      new(content: content)
    end
  end
end
