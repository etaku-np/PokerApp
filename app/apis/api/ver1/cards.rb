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
            Errors.search_errors(body)
            Hands.search_hands(body)

            if Errors.determine != nil
              error = {
                "cards" => body,
                "msg" => Errors.determine
              }
            else
              @score_array << $score


              result = {
                "cards" => body,
                "hands" => Hands.judge,
                "best" => $score
              }
            end


            @results << result
            @errors << error

          end

          @results.compact!
          @errors.compact!

          # binding.pry

          responses = {
            "results" => @results,
            "errors" => @errors
          }
          responses

        end
      #end
    end
  end
end
