module API
  module Ver1
    class Cards < Grape::API
      include PokerService

      params do
        requires :cards, type: Array
      end

      resource :poker do
        post do
          cards_set = params[:cards]
          error!({ errors: [{ msg: "入力内容を確認してください。" }] }, 400) if cards_set.empty?
          error!({ errors: [{ msg: "入力内容が重複しています。" }] }, 400) if cards_set != cards_set.uniq
          present PokerService.compare_results(cards_set)
          status 200
        end
      end
    end
  end
end