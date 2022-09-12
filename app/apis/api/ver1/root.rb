module API
  module Ver1
    class Root < Grape::API
      version 'v1', using: :path
      format :json
      mount API::Ver1::Cards
    end
  end
end
