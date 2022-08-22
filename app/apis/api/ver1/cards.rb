module API
  module Ver1
    class Cards < Grape::API

      include Hands
      include Errors
      # include Score

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
          cards.each do |body|
            Errors.search_errors(body)
            Hands.search_hands(body)
            # Score.search_score(body)

            if Errors.determine != nil
              error = {
                "cards" => body,
                "msg" => Errors.determine
              }
            else
              result = {
                "cards" => body,
                "hands" => Hands.judge,
                # "score" => Score.calc
              }
            end

            @results << result
            @errors << error

          end
          # binding.pry
          @results.compact!
          @errors.compact!

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
