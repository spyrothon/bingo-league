class BingoWeb::API::SessionsController < BingoWeb::Controller
  private alias Query     = BingoLeague::Query
  private alias Accounts  = BingoLeague::Accounts

  def create
    username = json_params["username"].as_s
    password = json_params["password"].as_s

    account = Accounts.list_users(Query.where(name: username)).first?

    unless account
      render_error_json(422, "Invalid username/password")
      return
    end

    if session = Accounts.create_session(account, password)
      user = Accounts.get_user(session.instance.user_id)
      render_json({
        session_id: session.instance.key!,
        user: user
      })
    else
      render_error_json(422, "Invalid username/password")
    end
  end

  def destroy
    if session = @context.session?
      Accounts.invalidate_session(session)
    end

    redirect_to("/")
  end
end
