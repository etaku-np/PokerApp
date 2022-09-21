# 入力されたカードの役を判定
module PokerHand
  HAND_SET = {
    straight_flash: { name: "ストレートフラッシュ", score: 8 },
    four_card: { name: "フォーカード", score: 7 },
    full_house: { name: "フルハウス", score: 6 },
    flush: { name: "フラッシュ", score: 5 },
    straight: { name: "ストレート", score: 4 },
    three_card: { name: "スリーカード", score: 3 },
    two_pair: { name: "ツーペア", score: 2 },
    one_pair: { name: "ワンペア", score: 1 },
    high_card: { name: "ハイカード", score: 0 }
  }

  def judge_cards(cards)
    judge(cards)
  end

  def flush?(cards)
    true if suit_array(cards).uniq.length == 1
  end

  def straight?(cards)
    num_array = num_array(cards)
    true if ( (num_array.uniq.length == 5) && (num_array.max - num_array.min == 4) ) || num_array == [1, 10, 11, 12, 13]
  end

  def four_card?(cards)
    true if num_count_array(cards) == [1, 4]
  end

  def full_house?(cards)
    true if num_count_array(cards) == [2, 3]
  end

  def three_card?(cards)
    true if num_count_array(cards) == [1, 1, 3]
  end

  def two_pair?(cards)
    true if num_count_array(cards) == [1, 2, 2]
  end

  def one_pair?(cards)
    true if num_count_array(cards) == [1, 1, 1, 2]
  end

  def judge(cards)
    if flush?(cards) && straight?(cards)
      HAND_SET[:straight_flash]
    elsif four_card?(cards)
      HAND_SET[:four_card]
    elsif full_house?(cards)
      HAND_SET[:full_house]
    elsif flush?(cards)
      HAND_SET[:flush]
    elsif straight?(cards)
      HAND_SET[:straight]
    elsif three_card?(cards)
      HAND_SET[:three_card]
    elsif two_pair?(cards)
      HAND_SET[:two_pair]
    elsif one_pair?(cards)
      HAND_SET[:one_pair]
    else
      HAND_SET[:high_card]
    end
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

  module_function :judge_cards, :suit_array, :num_array, :num_count_array, :flush?, :straight?, :full_house?, :four_card?, :three_card?, :two_pair?, :one_pair?, :judge

end

