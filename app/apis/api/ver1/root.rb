module API
  module Ver1
    class Root < Grape::API
      version 'v1', using: :path
      format :json
      default_format :json
      content_type :json, "application/json"
      content_type :xml, 'application/xml'
      content_type :javascript, 'application/javascript'
      content_type :txt, 'text/plain'
      content_type :html, 'text/html'

      rescue_from Grape::Exceptions::Base do |_e|
        error!({ errors: [{ msg: "入力形式を確認してください。" }] }, 400)
      end

      mount API::Ver1::Cards
    end
  end
end
