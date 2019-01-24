class BingoWeb::SessionsController < BingoWeb::Controller
  private alias Query     = BingoLeague::Query
  private alias Accounts  = BingoLeague::Accounts

  def new
    redirect_target = query_params["redirect"]? || "/"
    render("sessions/new.html.j2")
  end

  def create
    username = body_params["username"]
    password = body_params["password"]
    redirect_target = query_params["redirect"]? || "/"

    account = Accounts.list_users(Query.where(name: username)).first

    unless account
      render_error(422, "Username does not exist")
      return
    end

    if session = Accounts.create_session(account, password)
      response.cookies["bingo-league_session_id"] = session.instance.key!
      redirect_to(redirect_target)
      return
    else
      render_error(422, "Could not log in")
      return
    end
  end

  def destroy
    if session = @context.session?
      Accounts.invalidate_session(session)
    end

    redirect_to("/")
  end
end
