module API
  module Ver1
    class Root < Grape::API
      # これでdomain/api/v1でアクセス出来るようになる。(versioning)
      version 'v1', using: :path
      format :json

      mount API::Ver1::Cards

      include Hands
      include Errors
      #include Scores

      def init

      end



    end
  end
end
