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
          present PokerService.compare_results(cards_set)
          status 200
        end
      end
    end
  end
end