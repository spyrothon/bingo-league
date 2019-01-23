require "orion"

router BingoWebRouter do
  use HTTP::ErrorHandler
  use HTTP::LogHandler.new(STDOUT)
  use SessionHandler

  concern :authenticated do
    use AuthenticationHandler
  end

  resources :matches


  get   "login",  to: "sessions#new", helper: "login"
  post  "login",  to: "sessions#create", helper: "sessions_create"
  get   "logout", to: "sessions#destroy", helper: "logout"


  ## Static assets
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
  scope "js" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
end
