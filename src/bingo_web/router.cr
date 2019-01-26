require "orion"

macro crud(name, singular)
  scope "{{name.id}}" do
    get   "",                             to: "{{name.id}}#index",    helper: "{{name.id}}"
    get   "/new",                         to: "{{name.id}}#new",      helper: "{{name.id}}_new"
    post  "/create",                      to: "{{name.id}}#create",   helper: "{{name.id}}_create"
    get   "/:{{singular.id}}_id",         to: "{{name.id}}#show",     helper: "{{name.id}}_show"
    get   "/:{{singular.id}}_id/edit",    to: "{{name.id}}#edit",     helper: "{{name.id}}_edit"
    post  "/:{{singular.id}}_id/update",  to: "{{name.id}}#update",   helper: "{{name.id}}_update"
    get   "/:{{singular.id}}_id/delete",  to: "{{name.id}}#delete",   helper: "{{name.id}}_delete"

    {{yield}}
  end
end

router BingoWeb::Router do
  use HTTP::ErrorHandler
  use HTTP::LogHandler.new(STDOUT)
  use SessionHandler

  concern :authenticated do
    use AuthenticationHandler
  end

  crud :matches,  "match" do
    post  "/:match_id/add_team",              to: "matches#add_team"
    get   "/:match_id/teams/:team_id/remove", to: "matches#remove_team"
  end

  crud :leagues,  "league"
  crud :plays,    "play"
  crud :players,  "player"
  crud :teams,    "team"


  get   "login",  to: "sessions#new", helper: "login"
  post  "login",  to: "sessions#create", helper: "sessions_create"
  get   "logout", to: "sessions#destroy", helper: "logout"


  scope "api" do
    get   "/leagues/:league_id", controller: API::LeaguesController, action: show

    post  "/matches/create", controller: API::MatchesController, action: create
  end


  ## Static assets
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
  scope "js" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
end
