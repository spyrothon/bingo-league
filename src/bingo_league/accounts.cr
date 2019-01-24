require "./accounts/**"

module BingoLeague::Accounts
  extend self

  ###
  # Users
  ###

  def list_users(query : Query = Query.new)
    Repo.all(User, query)
  end

  def get_user(user_id, query : Query = Query.new)
    Repo.all(User, query.where(id: user_id).limit(1)).first?
  end

  def get_user_for_session(session : Session)
    Repo.get(User, session.user_id)
  end

  def new_user()
    User.new
  end

  def create_user(attrs)
    user = User.new
    user.admin = false
    user = user.cast(attrs)
    Repo.insert(user)
  end

  def update_user(user : User, changes)
    return unless validate_password_matches(changes)
    changeset = user.cast(changes)
    Repo.update(changeset)
  end

  def delete_user(user : User)
    Repo.delete(user)
  end

  private def validate_password_matches(changes)
    password = changes["password"]?
    confirm  = changes["password_confirm"]?

    password && confirm && password == confirm
  end



  ###
  # Sessions
  ###

  def get_session(session_id, query : Query = Query.new)
    Repo.all(Session, query.where(key: session_id)).first?
  end

  def get_valid_session(session_id, query : Query = Query.new)
    get_session(session_id, query.where(valid: "true"))
  end

  def create_session(user : User, password : String)
    if user.password_matches?(password)
      session = Session.new.cast({
        "key" => Random::Secure.hex(32),
        "user_id" => user.id.to_s,
        "valid" => "true"
      })
      Repo.insert(session)
    end
  end

  def invalidate_session(session : Session)
    session.valid = false
    Repo.update(session)
  end
end
