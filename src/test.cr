require "./bingo_league/rooms"

room_id = 123_i64
board = ["goal1", "goal2", "goal3"]
board2 = ["goal1", "goal2", "goal3", "goal4", "goal5"]
players = [] of String

events = [
  RoomEvent.room_created(room_id, "Room 2"),
  RoomEvent.board_changed(room_id, board),
  RoomEvent.player_added(room_id, "shark"),
  RoomEvent.player_added(room_id, "faulty"),
  RoomEvent.board_changed(room_id, board2)
]

agg = RoomAggregate.from_events(room_id, events)

pp! agg
