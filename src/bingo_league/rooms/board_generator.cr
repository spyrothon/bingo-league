module Rooms
  class BoardGenerator
    property size : Int32
    property seed : Int64
    property goals : Hash(Int32, Array(Goal))

    private property random : Random
    private property table1 : Array(Int32)
    private property table2 : Array(Int32)

    def initialize(@size : Int32, goals : Array(Goal), seed : Int? = nil)
      @seed = seed.to_i64 || Time.now.epoch
      @random = Random.new(@seed)
      @goals = goals.group_by(&.difficulty.as(Int32))

      # Two random orders of 0..4 used to calculate fair difficulty values at
      # every position in the grid
      @table1 = (0..(@size-1)).to_a.shuffle!(@random)
      @table2 = (0..(@size-1)).to_a.shuffle!(@random)
    end

    def generate
      board_difficulties = Array(Int32).new(size * size) do |idx|
        difficulty_at(idx)
      end

      cells = board_difficulties.map do |difficulty|
        goals[difficulty+1].sample
      end.map do |goal|
        Cell.new(goal)
      end

      Board.new(size, seed, cells)
    end


    private def difficulty_at(idx : Int32)
      # TODO: Comment what this actually does. It's akin to randomly indexing
      # a square using the index as a seed for the randomness. Each index
      # should hit a unique position in the square, meaning no numbers get
      # repeated.
      idx = idx - 1
      x = idx % size
      y = idx / size

      h = table1[(3*x + y) % size]
      v = table2[(x + 3*y) % size]

      v*size + h
    end
  end
end
