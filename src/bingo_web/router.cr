require "orion"

macro crud(name, singular, *, controller=nil)
  {% controller = controller || name %}

  scope "{{name.id}}" do
    get   "",                             to: "{{controller.id}}#index",    helper: "{{name.id}}"
    get   "/new",                         to: "{{controller.id}}#new",      helper: "{{name.id}}_new"
    post  "/create",                      to: "{{controller.id}}#create",   helper: "{{name.id}}_create"
    get   "/:{{singular.id}}_id",         to: "{{controller.id}}#show",     helper: "{{name.id}}_show"
    get   "/:{{singular.id}}_id/edit",    to: "{{controller.id}}#edit",     helper: "{{name.id}}_edit"
    post  "/:{{singular.id}}_id/update",  to: "{{controller.id}}#update",   helper: "{{name.id}}_update"
    get   "/:{{singular.id}}_id/delete",  to: "{{controller.id}}#delete",   helper: "{{name.id}}_delete"

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

  crud :matches,  "match"
  crud :players,  "player"
  crud :teams,    "team"


  get   "login",  to: "sessions#new", helper: "login"
  post  "login",  to: "sessions#create", helper: "sessions_create"
  get   "logout", to: "sessions#destroy", helper: "logout"

  scope "api" do
    crud :matches, "match", controller: "aPI::Matches"

    get "/teams", controller: API::TeamsController, action: index
  end


  ## Static assets
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
  scope "js" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
end
