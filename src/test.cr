require "dotenv"
Dotenv.load!

require "./bingo_league/rooms"

room_id = 123_i64
board = Rooms::Board.new(
  goals: [
    Rooms::Goal.new(name: "Goal 1", difficulty: 2, types: ["gems", "orbs"]),
    Rooms::Goal.new(name: "Goal 2", difficulty: 15),
    Rooms::Goal.new(name: "Goal 3", difficulty: 3),
    Rooms::Goal.new(name: "Goal 4", difficulty: 7)
  ]
)


context = Rooms::Context.new
# commands = [
#   Rooms::Commands::UpdateBoard.new(board: board)
# ]
# commands.map do |command|
#   agg = context.get_room(room_id)
#   events = agg.process(command)
#   context.emit(events)
# end


agg = context.get_room(room_id)
pp! agg
