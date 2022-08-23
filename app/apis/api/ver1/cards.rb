module API
  module Ver1
    class Cards < Grape::API

      include Hands
      include Errors

      # resource :cards do

        content_type :json, 'application/json'
        format :json

        desc 'ここに説明を書く'
        params do
          requires :cards, type: Array, desc: 'Entered cards'
        end

        post do
          cards = params[:cards]
          @results = []
          @errors = []
          @score_array = []

          cards.each do |body|
            if Errors.search_errors(body)
              error = {
                "cards" => body,
                "msg" => Errors.search_errors(body)
              }
            else
              @score_array << Hands.search_hands(body)[:score]
              result = {
                "cards" => body,
                "hands" => Hands.search_hands(body)[:name],
                "score" => Hands.search_hands(body)[:score]
              }
            end
            @results << result
            @errors << error
          end

          @results.compact!
          @errors.compact!

          # binding.pry

          response = {
            "results" => @results,
            "errors" => @errors
          }
          response

        end
      #end
    end
  end
end
