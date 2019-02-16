require "./bingo_league/rooms"

room_id = 123_i64
cells = ["goal1", "goal2", "goal3"]
cells2 = ["goal1", "goal2", "goal3", "goal4", "goal5"]
players = [] of String

events = [
  RoomEvent.room_created(room_id, cells, players),
  RoomEvent.player_added(room_id, "faulty"),
  RoomEvent.player_added(room_id, "shark"),
  RoomEvent.board_changed(room_id, cells2),
  RoomEvent.board_changed(room_id, cells),
  RoomEvent.board_changed(room_id, cells2),
  RoomEvent.player_added(room_id, "art"),
  RoomEvent.player_added(room_id, "drashed"),
  RoomEvent.player_added(room_id, "shaw"),
  RoomEvent.player_added(room_id, "wally"),
]

agg = RoomAggregate.from_events(room_id, events)

pp! agg
