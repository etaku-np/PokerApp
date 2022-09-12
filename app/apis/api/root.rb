# require 'grape'
module API
  class Root < Grape::API
    prefix 'api'
    format :json
    default_format :json
    content_type :json, "application/json"
    content_type :xml, 'application/xml'
    content_type :javascript, 'application/javascript'
    content_type :txt, 'text/plain'
    content_type :html, 'text/html'
    mount API::Ver1::Root
  end
end
