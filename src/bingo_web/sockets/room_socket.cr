class BingoWeb::RoomSocket
  @@sockets = Hash(String, Array(self)).new

  def self.add(socket : HTTP::WebSocket, context : HTTP::Server::Context)
    room_id = context.request.path_params["room_id"]
    handler = new(room_id, socket)
    if room_sockets = @@sockets[room_id]?
      room_sockets.push(handler)
    else
      @@sockets[room_id] = [handler]
    end
    nil
  end

  def initialize(room_id : String, socket : HTTP::WebSocket)
  end
end
