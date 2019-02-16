require "dotenv"
Dotenv.load!

require "./bingo_league/rooms"

room_id = 123_i64
board = ["goal1", "goal2", "goal3"]
board2 = ["goal1", "goal2", "goal3", "goal4", "goal5"]

events = [
  Rooms::RoomEvent.room_created(room_id, "Room 2"),
  Rooms::RoomEvent.board_changed(room_id, board),
  Rooms::RoomEvent.player_added(room_id, "shark"),
  Rooms::RoomEvent.player_added(room_id, "faulty"),
  Rooms::RoomEvent.board_changed(room_id, board2)
]

context = Rooms::Context.new

agg = context.get_room(room_id)

pp! agg
