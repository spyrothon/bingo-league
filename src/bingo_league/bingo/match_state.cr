require "crinja"

module BingoLeague::Bingo
  record MatchState,
    status = "created",
    teams = [] of Team,
    players = [] of Player,
    scores = {} of Player => Int32
end
