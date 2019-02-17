require "auto_initialize"

class Rooms::Goal
  include AutoInitialize
  JSON.mapping(
    name: String,
    difficulty: Int32,
    types: Array(String),
    marked_by: Array(String)
  )


  def initialize(@name, @difficulty = 1, @types = [] of String, @marked_by = [] of String)
  end
end
