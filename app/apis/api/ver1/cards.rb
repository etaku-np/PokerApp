module API
  module Ver1
    class Cards < Grape::API
      include Hands
      include Errors
      include Best

      format :json
      default_format :json
      content_type :json, "application/json"
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
        cards_set = params[:cards]
        error!({ errors: [{ msg: "入力内容を確認してください。" }] }, 400) if cards_set.empty?

        # エラーがないカードは、役を判定する
        correct_cards_set = cards_set.select { |cards| Errors.search_errors(cards).nil? }
        @results = correct_cards_set.map do |cards|
          {
            "cards" =>  cards,
            "hand"  =>  Hands.search_hands(cards)[:name],
            "best"  =>  Hands.search_hands(cards)[:score]
          }
        end
        @score_array = correct_cards_set.map{ |cards| Hands.search_hands(cards)[:score] }
        # @resultsを、役最強部分を更新した状態に上書き
        @results = Best.search_best(@score_array, @results)

        # エラーがあるコードは、エラーを判定する
        incorrect_cards_set = cards_set - correct_cards_set
        @errors = incorrect_cards_set.map do |cards|
          {
            "cards" =>  cards,
            "msg"   =>  Errors.search_errors(cards)
          }
        end
        response = { "results" => @results, "errors" => @errors }
        status 200
        # 役またはエラーのみの場合、空の配列を表示しない
        response.delete_if{ |_, v| v.empty? }
      end
    end
  end
end
