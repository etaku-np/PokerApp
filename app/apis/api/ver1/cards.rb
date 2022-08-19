module API
  module Ver1
    class Cards < Grape::API

      content_type :json, 'application/json'
      format :json
      params do
        requires :cards, type: Array
      end

      post do
        @cards = params[:cards]

      end

    end
  end

end
