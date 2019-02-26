require "./repo"
require "./rooms/supervisor.cr"
require "./rooms/goal"

module Rooms::Context
  extend self
  private alias Repo = BingoLeague::Repo
  private alias Query = BingoLeague::Query


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
    :process_and_save,
    to: supervisor
  )


  ###
  # Goals
  ###

  def list_goals(query : Query = Query.new)
    Repo.all(Goal, query)
  end

  def get_goal(goal_id, query : Query = Query.new)
    Repo.all(Goal, query.where(id: goal_id).limit(1)).first?
  end

  def get_goal!(goal_id, query : Query = Query.new)
    Repo.all(Goal, query.where(id: goal_id).limit(1)).first
  end

  def new_goal()
    Goal.new
  end

  def create_goal(attrs)
    goal = Goal.new
    goal = goal.cast(attrs)
    Repo.insert(goal)
  end

  def update_goal(goal : Goal, changes)
    changeset = goal.cast(changes)
    Repo.update(changeset)
  end

  def delete_goal(goal : Goal)
    Repo.delete(goal)
  end
end
