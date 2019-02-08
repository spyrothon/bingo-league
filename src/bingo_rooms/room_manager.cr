require "./board_generator.cr"
require "./room.cr"
require "./storage.cr"

require "random/secure"

module BingoRooms::RoomManager
  extend self

  def list_rooms()
    Storage.list_rooms()
  end

  def get_room(room_id : String)
    Storage.get_room(room_id)
  end

  def get_room!(room_id : String)
    Storage.get_room(room_id)
  end

  def create_room(name : String)
    board = BoardGenerator.generate()
    id = Random::Secure.hex(10)

    room = Room.new(id, name, board)
    Storage.save_room(room)
    room
  end

  def remove_room(room_id : String)
    @@rooms.delete(room_id)
  end
end
