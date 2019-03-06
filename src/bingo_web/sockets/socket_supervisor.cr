class BingoWeb::SocketSupervisor
  class_property instance = new

  def self.start
    @@instance.run
  end


  property sockets : Set(Socket)
  property subscriptions : Hash(String, Set(Socket))

  def initialize
    @sockets = Set(Socket).new
    @subscriptions = {} of String => Set(Socket)
  end

  def self.add(socket : Socket)
    @@instance.sockets.add(socket)
    nil
  end

  def self.remove(socket : Socket)
    @@instance.sockets.delete(socket)
    @@instance.subscriptions.each do |topic, sockets|
      sockets.delete(socket)
    end
    nil
  end

  def self.subscribe(topic : String, socket : Socket)
    @@instance.subscriptions[topic] ||= Set(Socket).new
    @@instance.subscriptions[topic].add(socket)
    nil
  end

  def self.unsubscribe(topic : String, socket : Socket)
    @@instance.subscriptions[topic] ||= Set(Socket).new
    @@instance.subscriptions[topic].delete(socket)
    nil
  end

  def self.broadcast(topic : String, message)
    if subscriptions = @@instance.subscriptions[topic]?
      subscriptions.each do |sub|
        sub.send(message)
      end
    end
  end

  def run
    loop do
      keepalive()
      sleep(15)
    end
  end

  def keepalive
    @sockets.each do |socket|
      socket.pong
    end
  end
end
