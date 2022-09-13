module PokerService
  # webアプリケーションとAPIの処理を行うサービスです
  include PokerValidation
  include PokerHand
  include PokerBest

  def webapp(cards)
    # エラーメッセージがあればそれを、なければ（何かの役になっているはずなので）役の判定を出す。
    PokerValidation.validate_cards(cards) || PokerHand.judge_cards(cards)[:name]
  end

  def api(cards_set)
    valid_cards_set = cards_set.select { |cards| PokerValidation.validate_cards(cards).nil? }
    results = valid_cards_set.map do |cards|
      judge_result = PokerHand.judge_cards(cards)
      {
        "cards" =>  cards,
        "hand"  =>  judge_result[:name],
        "best"  =>  judge_result[:score]
      }
    end
    results = PokerBest.judge_best(results)

    invalid_cards_set = cards_set - valid_cards_set
    errors = invalid_cards_set.map do |cards|
      {
        "cards" =>  cards,
        "msg"   =>  PokerValidation.validate_cards(cards)
      }
    end

    response = { "results" => results, "errors" => errors }
    response.delete_if{ |_, v| v.empty? }
  end
  module_function :webapp, :api
end