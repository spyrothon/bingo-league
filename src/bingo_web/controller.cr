require "./util/template.cr"
require "./param_schemas/params.cr"
require "./param_schemas/*"

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

  def render_json(value, status=200)
    response.headers.add "Content-Type", "application/json"
    response.headers.add "Access-Control-Allow-Origin", "*"
    response.print({ data: value }.to_json)
  end

  def render_error(status : Int32, message : String)
    response.status_code = status
    response.print(message)
  end

  def render_error_json(status : Int32, message)
    response.headers.add "Content-Type", "application/json"
    response.headers.add "Access-Control-Allow-Origin", "*"
    response.status_code = status
    response.print({ error: message }.to_json)
  end


  property! body_params   : Hash(String, String)
  property! url_params    : Hash(String, String)
  property! query_params  : Hash(String, String)
  property! raw_request_body : String

  def raw_request_body
    @raw_request_body ||= begin
      if body = request.body
        body.not_nil!.gets_to_end
      else
        ""
      end
    end
  end

  def body_params
    @body_params ||= HTTP::Params.parse(raw_request_body).to_h
  end

  def json_params
    @json_params ||= JSON.parse(raw_request_body)
  end

  def structured_params(structure)
    body = raw_request_body
    unless body.empty?
      structure.from_json(body)
    else
      structure.from_json("{}")
    end
  end

  def url_params
    @url_params ||= request.path_params.to_h
  end

  def query_params
    @query_params ||= request.query_params.to_h
  end
end
