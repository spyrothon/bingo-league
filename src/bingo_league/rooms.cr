require "./rooms/supervisor.cr"

module Rooms::Context
  extend self

  @@supervisor : Supervisor?

  def supervisor
    if supervisor = @@supervisor
      supervisor
    else
      raise "Rooms supervisor not started!"
    end
  end

  def start
    @@supervisor = Supervisor.new
  end


  delegate(
    :list_rooms,
    :get_room,
    :events_for_room,
    :emit,
    to: supervisor
  )
end
