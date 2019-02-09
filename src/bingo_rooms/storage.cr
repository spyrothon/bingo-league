require "nuummite"

require "./room.cr"

module BingoRooms::Storage
  extend self

  STORE = Nuummite.new("./data/", "db.nuummite")

  CACHE = {} of String => Room


  def save_room(room : Room)
    update_cache(room)
    STORE["rooms/#{room.id}"] = room.to_json
  end

  def get_room(id : String)
    CACHE[id]? || begin
      room = Room.from_json(STORE["rooms/#{id}"])
      update_cache(room)
      room
    end
  end

  def list_rooms(cache_only=false)
    unless cache_only
      STORE.each("rooms/") do |id, room_json|
        CACHE[id] = Room.from_json(room_json)
      end
    end
    CACHE.values
  end

  def delete_room(id : String)
    CACHE.delete(room.id)
  end

  private def update_cache(room : Room)
    CACHE[room.id] = room
  end
end
