require "auto_initialize"

class Rooms::Goal
  include AutoInitialize
  JSON.mapping(
    name: String,
    difficulty: Int32,
    types: Array(String),
    marked_by: Set(String)
  )


  def initialize(@name, @difficulty = 1, @types = [] of String, @marked_by = Set(String).new)
  end
end
