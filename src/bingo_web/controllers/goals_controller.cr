require "../../bingo_league/rooms"

class BingoWeb::GoalsController < BingoWeb::Controller
  private alias Query = BingoLeague::Query

  def index
    goals = Rooms::Context.list_goals()

    render("goals/index.html.j2", {
      "goals" => goals
    })
  end

  def show
    if goal = Rooms::Context.get_goal(url_params["goal_id"])
      render("goals/show.html.j2", {
        "goal" => goal
      })
    else
      redirect_to goals_path
    end
  end

  def new
    goal = Rooms::Context.new_goal()
    render("goals/new.html.j2", {
      "goal" => goal
    })
  end

  def create
    Rooms::Context.create_goal(body_params)
    redirect_to goals_path
  end

  def edit
    goal_id = url_params["goal_id"]
    if goal = Rooms::Context.get_goal(goal_id)
      render("goals/edit.html.j2", {
        "goal" => goal
      })
    else
      redirect_to goals_path
    end
  end

  def update
    goal_id = url_params["goal_id"]
    if goal = Rooms::Context.get_goal(goal_id)
      Rooms::Context.update_goal(goal, body_params)
    end

    redirect_to goals_path
  end

  def delete
    goal_id = url_params["goal_id"]
    if goal = Rooms::Context.get_goal(goal_id)
      Rooms::Context.delete_goal(goal)
    end

    redirect_to goals_path
  end
end
