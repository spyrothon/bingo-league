module Params
  struct CreateRoom < ParamsBase
    include JSON::Serializable

    property name : String?
    property seed : Int32?
  end
end
