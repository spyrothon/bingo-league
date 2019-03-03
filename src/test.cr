require "dotenv"
Dotenv.load!

require "./bingo_league/rooms"

require "./goals.cr"

GOALS.each do |difficulty, goals|
  goals.each do |g|
    g = Rooms::Context.create_goal({
      name: g["name"],
      types: g["types"].as(Array(String)).join(","),
      difficulty: difficulty,
      clarification: nil
    })
    puts g
  end
end

