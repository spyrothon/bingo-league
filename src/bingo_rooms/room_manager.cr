require "./board_generator.cr"
require "./room.cr"

require "random/secure"

module BingoRooms::RoomManager
  extend self

  @@rooms = {} of String => Room


  def list_rooms()
    @@rooms.values
  end

  def get_room(room_id : String)
    @@rooms[room_id]?
  end

  def get_room!(room_id : String)
    @@rooms[room_id]
  end

  def create_room(name : String)
    board = BoardGenerator.generate()
    id = Random::Secure.hex(10)
    @@rooms[id] = Room.new(id, name, board)
  end

  def remove_room(room_id : String)
    @@rooms.delete(room_id)
  end
end
