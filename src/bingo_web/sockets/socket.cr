# A Read-only socket for publishing updates about room states to clients in
# real time. Commands are done through a standard REST API to simplify message
# handling. The only messages the socket responds to are subscription events.
class BingoWeb::Socket
  property socket : HTTP::WebSocket
  property context : HTTP::Server::Context

  def initialize(@socket : HTTP::WebSocket, @context : HTTP::Server::Context)
    @socket.on_message(&->handle_message(String))
    @socket.on_close{ SocketSupervisor.remove(self) }
    @socket.on_ping{ @socket.pong }
  end

  def handle_message(message : String)
    payload = JSON.parse(message)

    case command = payload["command"]
    when "subscribe"
      if topic = payload["topic"]
        SocketSupervisor.subscribe(topic.as_s, self)
        room_id = topic.as_s
        room = Rooms::Context.get_room(room_id)
        events = Rooms::Context.events_for_room(room_id)
        send({ type: "room_update", room: room, events: events })
      else
        send({ error: "no such topic", topic: topic })
      end
    when "unsubscribe"
      if topic = payload["topic"]
        SocketSupervisor.unsubscribe(topic.as_s, self)
        send({ type: "ok", status: "ok", topic: topic })
      else
        send({ error: "no such topic", topic: topic })
      end
    else
      puts "Unhandled socket command: #{command}"
    end

    nil
  end


  def send(content : String)
    @socket.send(content)
  end

  def send(content)
    @socket.send(content.to_json)
  end

  def pong
    @socket.pong
  end
end
