require "./repo.cr"
require "./league/schemas/**"
require "crecto"

module BingoLeague::League
  extend self

  ###
  # Matches
  ###

  def list_matches(query : Query = Query.new)
    Repo.all(Match, query.where(is_public: "true").preload([:plays, :teams]))
  end

  def get_match(match_id, query : Query = Query.new)
    Repo.all(Match, query.where(id: match_id).limit(1).preload([:plays, :teams])).first?
  end

  def get_match!(match_id, query : Query = Query.new)
    Repo.all(Match, query.where(id: match_id).limit(1).preload([:plays, :teams])).first
  end

  def new_match()
    match = Match.new
    match.plays = [] of Play
    match.teams = [] of Team
    match
  end

  def create_match(attrs)
    match = Match.new
    match = match.cast(attrs)
    changeset = Repo.insert(match)
  end

  def update_match(match : Match, changes)
    changeset = match.cast(changes)
    Repo.update(changeset)
  end

  def delete_match(match : Match)
    match_id = match.id
    Repo.delete_all(Play, Query.where(match_id: match_id))
    Repo.delete(match)
  end


  ###
  # Plays
  ###

  def list_plays(query : Query = Query.new)
    Repo.all(Play, query)
  end

  def get_play(play_id, query : Query = Query.new)
    Repo.all(Play, query.where(id: play_id).limit(1)).first?
  end

  def get_play!(play_id, query : Query = Query.new)
    Repo.all(Play, query.where(id: play_id).limit(1)).first
  end

  def new_play()
    Play.new
  end

  def create_play(attrs)
    play = Play.new
    play = play.cast(attrs)
    # Ensure that when plays have no score, they don't count as `won`.
    if play.instance.score.nil?
      play.instance.won = false
    end
    Repo.insert(play)
  end

  def update_play(play : Play, changes)
    changeset = play.cast(changes)
    Repo.update(changeset)
  end

  def delete_play(play : Play)
    Repo.delete(play)
  end



  ###
  # Players
  ###

  def list_players(query : Query = Query.new)
    Repo.all(Player, query)
  end

  def get_player(player_id, query : Query = Query.new)
    Repo.all(Player, query.where(id: player_id).limit(1)).first?
  end

  def get_player!(player_id, query : Query = Query.new)
    Repo.all(Player, query.where(id: player_id).limit(1)).first
  end

  def new_player()
    Player.new
  end

  def create_player(attrs)
    player = Player.new
    player = player.cast(attrs)
    Repo.insert(player)
  end

  def update_player(player : Player, changes)
    changeset = player.cast(changes)
    Repo.update(changeset)
  end

  def delete_player(player : Player)
    Repo.delete(player)
  end



  ###
  # Teams
  ###

  def list_teams(query : Query = Query.new)
    Repo.all(Team, query)
  end

  def get_team(team_id, query : Query = Query.new)
    Repo.all(Team, query.where(id: team_id).limit(1)).first?
  end

  def get_team!(team_id, query : Query = Query.new)
    Repo.all(Team, query.where(id: team_id).limit(1)).first
  end

  def new_team()
    Team.new
  end

  def create_team(attrs)
    team = Team.new
    team = team.cast(attrs)
    Repo.insert(team)
  end

  def update_team(team : Team, changes)
    changeset = team.cast(changes)
    Repo.update(changeset)
  end

  def delete_team(team : Team)
    Repo.delete(team)
  end
end
