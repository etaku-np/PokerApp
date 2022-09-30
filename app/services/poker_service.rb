# frozen_string_literal: true
# webアプリケーションとAPIの処理を行うサービスです
module PokerService
  include PokerSyntaxError
  include PokerHand
  include PokerBest

  def judge_results(cards)
    PokerSyntaxError.check_syntax_errors(cards) || PokerHand.judge(cards)[:name]
  end

  def compare_results(cards_set)
    invalid_cards_set = cards_set.select { |cards| PokerSyntaxError.check_syntax_errors(cards)&.any? }
    errors = invalid_cards_set.map do |cards|
      {
        cards: cards,
        msg: PokerSyntaxError.check_syntax_errors(cards)
      }
    end

    valid_cards_set = cards_set - invalid_cards_set
    results = valid_cards_set.map do |cards|
      judge_result = PokerHand.judge(cards)
      {
        cards: cards,
        hand: judge_result[:name],
        best: judge_result[:score]
      }
    end
    results = PokerBest.judge_best(results)

    response = { results: results, errors: errors }
    response.delete_if{ |_, v| v.empty? }
  end

  def invalid_cards_set?(cards_set)
    cards_set.empty? || (cards_set != cards_set.uniq)
  end

  def cards_set_error_msg(cards_set)
    {
      errors: [{ msg: 'カードが入力されていないか、重複したカード組が入力されています。' }],
      duplicate: [{ cards: cards_set.select{ |card| cards_set.count(card) > 1 }.uniq }]
    }
  end

  module_function :judge_results, :compare_results, :cards_set_error_msg, :invalid_cards_set?
end
