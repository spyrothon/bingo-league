require "orion"

macro crud(name, singular, *, controller=nil, helpers=true)
  {% controller = controller || name %}

  scope "{{name.id}}" do
    get   "",                             to: "{{controller.id}}#index"     {% if helpers %}, helper: "{{name.id}}" {% end %}
    get   "/new",                         to: "{{controller.id}}#new"       {% if helpers %}, helper: "{{name.id}}_new" {% end %}
    post  "/create",                      to: "{{controller.id}}#create"    {% if helpers %}, helper: "{{name.id}}_create" {% end %}
    get   "/:{{singular.id}}_id",         to: "{{controller.id}}#show"      {% if helpers %}, helper: "{{name.id}}_show" {% end %}
    get   "/:{{singular.id}}_id/edit",    to: "{{controller.id}}#edit"      {% if helpers %}, helper: "{{name.id}}_edit" {% end %}
    post  "/:{{singular.id}}_id/update",  to: "{{controller.id}}#update"    {% if helpers %}, helper: "{{name.id}}_update" {% end %}
    get   "/:{{singular.id}}_id/delete",  to: "{{controller.id}}#delete"    {% if helpers %}, helper: "{{name.id}}_delete" {% end %}

    {{yield}}
  end
end

router BingoWeb::Router do
  use HTTP::ErrorHandler
  use HTTP::LogHandler.new(STDOUT)
  use SessionHandler

  concern :authorized_as_admin do
    use AuthenticationHandler
    use AuthorizationHandler
  end


  get "/",      to: "static#index"
  scope "play" do
    match "",          to: "static#play"
    match "/:room_id",  to: "static#play"
  end

  get   "login",  to: "sessions#new", helper: "login"
  post  "login",  to: "sessions#create", helper: "sessions_create"
  get   "logout", to: "sessions#destroy", helper: "logout"

  scope do
    implements :authorized_as_admin

    get "/admin", to: "static#admin"

    crud :matches,  "match"
    crud :players,  "player"
    crud :teams,    "team"
    crud :goals,    "goal"
  end


  scope "api" do
    use OptionsHandler

    crud :matches, "match", controller: "aPI::Matches", helpers: false

    get   "/teams", controller: API::TeamsController, action: index
    get   "/rooms", controller: API::RoomsController, action: index
    post  "/rooms", controller: API::RoomsController, action: create
    get   "/rooms/:room_id", controller: API::RoomsController, action: show
    get   "/rooms/:room_id/events", controller: API::RoomsController, action: events

    scope "/rooms/socket" do
      use HTTP::WebSocketHandler.new(&->RoomSocket.add(HTTP::WebSocket, HTTP::Server::Context))
    end
  end


  ## Static assets
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
  scope "js" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
end
