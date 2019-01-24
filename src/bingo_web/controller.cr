require "./util/template.cr"

class BingoWeb::Controller
  include Orion::ControllerHelper
  include BingoWeb::Router::Helpers

  def redirect_to(location, status : Int32 = 302)
    response.headers.add "Location", location
    response.status_code = status
  end

  def render(template, locals={} of String => String)
    Template.render(@context, template, locals)
  end

  def render_error(status : Int32, message : String)
    response.status_code = status
    response.print(message)
  end


  property! body_params   : Hash(String, String)
  property! url_params    : Hash(String, String)
  property! query_params  : Hash(String, String)

  def body_params
    @body_params ||= HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
  end

  def url_params
    @url_params ||= request.path_params.to_h
  end

  def query_params
    @query_params ||= request.query_params.to_h
  end
end
