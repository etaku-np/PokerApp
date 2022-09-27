# 入力されたカードの役を判定
module PokerHand
  HAND_SET = {
    straight_flush: { name: "ストレートフラッシュ", score: 8 },
    four_card: { name: "フォーカード", score: 7 },
    full_house: { name: "フルハウス", score: 6 },
    flush: { name: "フラッシュ", score: 5 },
    straight: { name: "ストレート", score: 4 },
    three_card: { name: "スリーカード", score: 3 },
    two_pair: { name: "ツーペア", score: 2 },
    one_pair: { name: "ワンペア", score: 1 },
    high_card: { name: "ハイカード", score: 0 }
  }

  def judge(cards)
    result_array = HAND_SET.keys.map(&:to_s).map do |x|
      send(x, cards)
    end
    # binding.pry
    result_array.compact![0]
  end

  def suit_array(cards)
    cards.scan(/[SHDC]/)
  end

  def num_array(cards)
    cards.scan(/1[0-3]|[1-9]/).map(&:to_i).sort
  end

  def num_count_array(cards)
    num_array = num_array(cards)
    (num_array.uniq.map{ |num| num_array.count(num) }).sort
  end

  def straight_flush(cards)
    HAND_SET[:straight_flush] if ([straight(cards)] + [flush(cards)]).compact.length == 2
  end

  def flush(cards)
    HAND_SET[:flush] if suit_array(cards).uniq.length == 1
  end

  def straight(cards)
    num_array = num_array(cards)
    HAND_SET[:straight] if ( (num_array.uniq.length == 5) && (num_array.max - num_array.min == 4) ) || num_array == [1, 10, 11, 12, 13]
  end

  def four_card(cards)
    HAND_SET[:four_card] if num_count_array(cards) == [1, 4]
  end

  def full_house(cards)
    HAND_SET[:full_house] if num_count_array(cards) == [2, 3]
  end

  def three_card(cards)
    HAND_SET[:three_card] if num_count_array(cards) == [1, 1, 3]
  end

  def two_pair(cards)
    HAND_SET[:two_pair] if num_count_array(cards) == [1, 2, 2]
  end

  def one_pair(cards)
    HAND_SET[:one_pair] if num_count_array(cards) == [1, 1, 1, 2]
  end

  def high_card(cards)
    HAND_SET[:high_card] unless ([straight(cards)] + [flush(cards)]).any? && num_count_array(cards) == [1, 1, 1, 1, 1]
  end

  module_function :suit_array, :num_array, :num_count_array, :straight_flush, :flush, :straight, :full_house, :four_card, :three_card, :two_pair, :one_pair, :high_card, :judge

end