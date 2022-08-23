module Hands

  def search_hands(cards)

    @carr = cards.split
    #受け取ったカードを、スートとナンバーに分ける
    @suit_array = cards.delete("^SHDC ").split
    @num_array_s = cards.delete("^0-9 ").split
    #ナンバーを文字列から数値に変換して、並び替え
    @num_array_i = @num_array_s.map(&:to_i).sort

  end

  def flush?
    true if @suit_array.uniq.length == 1
  end

  def straight?
    true if (@num_array_i.uniq.length == 5) && (@num_array_i.max - @num_array_i.min == 4) || @num_array_i == [1, 10, 11, 12, 13]
  end

  def combination
    #とりあえず空の配列を作る
    @hands_array = []

    #カードの組み合わせを配列で表示する。
    (0..@num_array_i.uniq.length - 1).each do |n|
      @hands_array[n] = @num_array_i.count(@num_array_i.uniq[n])
      @hands_array.sort!
    end

  end

  def four_card?
    true if @hands_array == [1, 4]
  end

  def full_house?
    true if @hands_array == [2, 3]
  end

  def three_card?
    true if @hands_array == [1, 1, 3]
  end

  def two_pair?
    true if @hands_array == [1, 2, 2]
  end

  def one_pair?
    true if @hands_array == [1, 1, 1, 2]
  end

  def judge
    combination

    if flush? && straight?
      $score = 8
      "ストレートフラッシュ"
    elsif flush?
      $score = 7
      "フラッシュ"
    elsif straight?
      $score = 6
      "ストレート"
    elsif four_card?
      $score = 5
      "フォーカード"
    elsif full_house?
      $score = 4
      "フルハウス"
    elsif three_card?
      $score = 3
      "スリーカード"
    elsif two_pair?
      $score = 2
      "ツーペア"
    elsif one_pair?
      $score = 1
      "ワンペア"
    else
      $score = 0
      "ハイカード"
    end

  end

  module_function :search_hands, :combination, :flush?, :straight?, :full_house?, :four_card?, :three_card?, :two_pair?, :one_pair?, :judge

end

