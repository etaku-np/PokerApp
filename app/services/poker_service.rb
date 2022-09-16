module PokerService
  # webアプリケーションとAPIの処理を行うサービスです
  include PokerValidation
  include PokerHand
  include PokerBest

  def judge_results(cards)
    PokerValidation.validate_cards(cards) || PokerHand.judge_cards(cards)[:name]
  end

  def compare_results(cards_set)
    invalid_cards_set = cards_set.select { |cards| PokerValidation.validate_cards(cards)&.any? }
    errors = invalid_cards_set.map do |cards|
      {
        "cards" =>  cards,
        "msg"   =>  PokerValidation.validate_cards(cards)
      }
    end

    valid_cards_set = cards_set - invalid_cards_set
    results = valid_cards_set.map do |cards|
      judge_result = PokerHand.judge_cards(cards)
      {
        "cards" =>  cards,
        "hand"  =>  judge_result[:name],
        "best"  =>  judge_result[:score]
      }
    end
    results = PokerBest.judge_best(results)

    response = { "results" => results, "errors" => errors }
    response.delete_if{ |_, v| v.empty? }
  end

  module_function :judge_results, :compare_results
end