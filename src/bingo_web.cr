require "pg"
require "crecto"
require "honcho"
require "orion"

require "dotenv"

Dotenv.load!

module BingoWeb
  APP_PORT = ENV["PORT"].to_i

  def self.start
    puts "bingo_web[router] is running on port #{APP_PORT}"
    Router.listen(host: "0.0.0.0", port: APP_PORT)
  end
end

require "./bingo_web/router.cr"
require "./bingo_web/controller.cr"
require "./bingo_web/**"
require "./bingo_league/rooms.cr"


visor = Honcho::Visor.new(strategy: Honcho::Strategy::ISOLATED)
visor.start_supervised("rooms_supervisor"){ Rooms::Context.start }
visor.start_supervised("bingo_web[router]", &->BingoWeb.start)
visor.start_supervised("socket_keepalive", &->BingoWeb::SocketSupervisor.start)
visor.run
