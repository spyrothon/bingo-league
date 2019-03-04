require "http"

class BingoWeb::OptionsHandler
  include HTTP::Handler

  def call(conn : HTTP::Server::Context)
    if conn.request.method.downcase == "options"
      conn.response.status_code = 200
      conn.response.headers.add "Access-Control-Allow-Origin", "*"
      conn.response.headers.add "Access-Control-Allow-Headers", "*"
      conn.response.headers.add "Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE"
      conn.response.print("OK")
      return
    end

    call_next(conn)
  end
end
