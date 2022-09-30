# 入力されたカードの不正な入力を判定
module PokerSyntaxError
  CORRECT = /^([SHDC])([1-9]|1[0-3])$/.freeze

  def check_syntax_errors(cards)
    if cards.blank?
      ['カードを入力してください。']
    elsif invalid_class?(cards)
      ['文字列を入力してください。']
    else
      card_array = cards.split
      invalid_total_cards?(card_array) || invalid_num_or_suit(card_array) || duplicate(card_array)
    end
  end

  def invalid_class?(cards)
    true unless cards.is_a?(String)
  end

  def invalid_total_cards?(card_array)
    ['5つのカード指定文字を半角スペース区切りで入力してください。'] if card_array.length != 5
  end

  def duplicate(card_array)
    ['カードが重複しています。'] if card_array.uniq.length != 5
  end

  def invalid_num_or_suit(card_array)
    error_msg_array = []
    card_array.each.with_index(1) do |card, i|
      error_msg_array.push("#{i}番目のカード指定文字が不正です。(#{card})") if invalid_num_or_suit?(card)
    end
    error_msg_array.blank? ? nil : error_msg_array
  end

  def invalid_num_or_suit?(card)
    true if card !~ CORRECT
  end

  module_function :check_syntax_errors, :invalid_total_cards?, :invalid_class?, :duplicate, :invalid_num_or_suit,
                  :invalid_num_or_suit?
end

