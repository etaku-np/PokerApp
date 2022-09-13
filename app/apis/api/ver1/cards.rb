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
          status 200
          response = PokerService.api(cards_set)
          present response.delete_if{ |_, v| v.empty? }
        end
      end
    end
  end
end