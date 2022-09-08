module API
  module Ver1
    class Cards < Grape::API
      include Hands
      include Errors
      include Best

      content_type :json, "application/json"
      format :json
      default_format :json
      content_type :xml, 'application/xml'
      content_type :javascript, 'application/javascript'
      content_type :txt, 'text/plain'
      content_type :html, 'text/html'

      params do
        requires :cards, type: Array
      end

      rescue_from Grape::Exceptions::Base do |_e|
        error!({ errors: [{ msg: "入力形式を確認してください。" }] }, 400)
      end

      post do
        cards_sets = params[:cards]
        @results = []
        @errors = []
        @score_array = []

        error!({ errors: [{ msg: "入力内容を確認してください。"}] }, 400) if cards_sets.empty?

        cards_sets.each do |cards_set|
          if Errors.search_errors(cards_set)
            error = {
              "cards" => cards_set,
              "msg" => Errors.search_errors(cards_set)
            }
            @errors << error
          else
            @score_array << Hands.search_hands(cards_set)[:score]
            result = {
              "cards" => cards_set,
              "hand" => Hands.search_hands(cards_set)[:name],
              "best" => Hands.search_hands(cards_set)[:score]
            }
            @results << result
          end
        end
        # @resultsを、役最強部分を更新した状態に上書き。
        @results = Best.search_best(@score_array, @results)

        response = {
          "results" => @results,
          "errors" => @errors
        }

        status 200
        # ハッシュの値が空の配列時、要素を削除する
        response.delete_if{ |_, value| value.empty? }
      end
    end
  end
end
