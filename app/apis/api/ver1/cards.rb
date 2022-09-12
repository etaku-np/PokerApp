module API
  module Ver1
    class Cards < Grape::API
      include HandService
      include ErrorService
      include BestService

      params do
        requires :cards, type: Array
      end

      resource :poker do
        post do
          cards_set = params[:cards]
          error!({ errors: [{ msg: "入力内容を確認してください。" }] }, 400) if cards_set.empty?
          error!({ errors: [{ msg: "入力内容が重複しています。" }] }, 400) if cards_set != cards_set.uniq

          correct_cards_set = cards_set.select { |cards| ErrorService.validate_cards(cards).nil? }
          results = correct_cards_set.map do |cards|
            judge_result = HandService.judge_cards(cards)
            {
              "cards" =>  cards,
              "hand"  =>  judge_result[:name],
              "best"  =>  judge_result[:score]
            }
          end
          score_array = results.map{ |result| result["best"] }
          results = BestService.judge_best(score_array, results)

          incorrect_cards_set = cards_set - correct_cards_set
          errors = incorrect_cards_set.map do |cards|
            {
              "cards" =>  cards,
              "msg"   =>  ErrorService.validate_cards(cards)
            }
          end

          response = { "results" => results, "errors" => errors }
          status 200
          present response.delete_if{ |_, v| v.empty? }
        end
      end
    end
  end
end