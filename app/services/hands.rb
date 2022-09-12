module Hands

  HAND_SET = {
    :straight_flash => { :name => "ストレートフラッシュ", :score => 8 },
    :four_card => { :name => "フォーカード", :score => 7 },
    :full_house => { :name => "フルハウス", :score => 6 },
    :flush => { :name => "フラッシュ", :score => 5 },
    :straight => { :name => "ストレート", :score => 4 },
    :three_card => { :name => "スリーカード", :score => 3 },
    :two_pair => { :name => "ツーペア", :score => 2 },
    :one_pair => { :name => "ワンペア", :score => 1 },
    :high_card => { :name => "ハイカード", :score => 0 }
  }

  def judge_cards(cards)
    @suit_array = cards.scan(/[SHDC]/)
    @num_array = cards.scan(/1[0-3]|[1-9]/).map(&:to_i).sort
    judge
  end

  def flush?
    true if @suit_array.uniq.length == 1
  end

  def straight?
    true if ( (@num_array.uniq.length == 5) && (@num_array.max - @num_array.min == 4) ) || @num_array == [1, 10, 11, 12, 13]
  end

  def combination # 同じナンバーを数えて配列で出す。
    @num_count_array = (@num_array.uniq.map{ |num| @num_array.count(num) }).sort
  end

  def four_card?
    true if @num_count_array == [1, 4]
  end

  def full_house?
    true if @num_count_array == [2, 3]
  end

  def three_card?
    true if @num_count_array == [1, 1, 3]
  end

  def two_pair?
    true if @num_count_array == [1, 2, 2]
  end

  def one_pair?
    true if @num_count_array == [1, 1, 1, 2]
  end

  def judge
    combination
    if flush? && straight?
      HAND_SET[:straight_flash]
    elsif four_card?
      HAND_SET[:four_card]
    elsif full_house?
      HAND_SET[:full_house]
    elsif flush?
      HAND_SET[:flush]
    elsif straight?
      HAND_SET[:straight]
    elsif three_card?
      HAND_SET[:three_card]
    elsif two_pair?
      HAND_SET[:two_pair]
    elsif one_pair?
      HAND_SET[:one_pair]
    else
      HAND_SET[:high_card]
    end
  end

  module_function :judge_cards, :combination, :flush?, :straight?, :full_house?, :four_card?, :three_card?, :two_pair?, :one_pair?, :judge

end

