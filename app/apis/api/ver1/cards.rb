module API
  module Ver1
    class Cards < Grape::API
      include HandService
      include ErrorService
      include BestService

      params do
        requires :cards, type: Array
      end

      rescue_from Grape::Exceptions::Base do |_e|
        error!({ errors: [{ msg: "入力形式を確認してください。" }] }, 400)
      end

      resource :poker do
        post do
          cards_set = params[:cards]
          error!({ errors: [{ msg: "入力内容を確認してください。" }] }, 400) if cards_set.empty?

          # エラーがないカードは、役を判定する
          correct_cards_set = cards_set.select { |cards| ErrorService.validate_cards(cards).nil? }
          @results = correct_cards_set.map do |cards|
            {
              "cards" =>  cards,
              "hand"  =>  HandService.judge_cards(cards)[:name],
              "best"  =>  HandService.judge_cards(cards)[:score]
            }
          end
          @score_array = correct_cards_set.map{ |cards| HandService.judge_cards(cards)[:score] }
          # @resultsを、役最強部分を更新した状態に上書き
          @results = BestService.judge_best(@score_array, @results)

          # エラーがあるコードは、エラーを判定する
          incorrect_cards_set = cards_set - correct_cards_set
          @errors = incorrect_cards_set.map do |cards|
            {
              "cards" =>  cards,
              "msg"   =>  ErrorService.validate_cards(cards)
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
end
