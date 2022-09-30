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
          if PokerService.invalid_cards_set?(cards_set)
            present PokerService.cards_set_error_msg(cards_set)
            status 400
          else
            present PokerService.compare_results(cards_set)
            status 200
          end
        end
      end
    end
  end
end