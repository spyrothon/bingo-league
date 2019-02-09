require "./goal_lists"

module BingoRooms::BoardGenerator
  extend self

  def generate(size : Int32 = 5, goal_list = GoalLists::SPYRO_2__4_1)
    square = magic_square(size)
    goal_list = populate_goals(square, goal_list)
    cells = goal_list.map do |n|
      Cell.new("#{n}")
    end

    Board.new(cells)
  end

  # Simple Siamese method magic square. Suitable for lockout bingos where
  # diagonal consistency is not necessary
  private def magic_square(size)
    x_rotation = Random::Secure.rand(5)
    y_rotation = Random::Secure.rand(5)
    (0...size).map do |i|
      (0...size).map do |j|
        size * ((i+j+1 + size/2) % size) + ((i + 2*j - 5) % size) + 1
      end.rotate!(x_rotation)
    end.rotate!(y_rotation).flatten
  end

  private def populate_goals(square, goal_list)
    square.map do |difficulty|
      goal_list[difficulty-1].sample(1)[0][:name]
    end
  end
end
