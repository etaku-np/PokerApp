CORRECT =/^([SHDC])([1-9]|1[0-3])$/
module Errors

  def search_errors(cards)

    if cards.blank? # 入力が空白だけか？
      ["カードを入力してください。"]
    elsif class_error?(cards)
      ["文字列を入力してください。"]
    elsif input_error?(cards)
      ["5つのカード指定文字を半角スペース区切りで入力してください。"]
    else # 不正なカードに対するエラー文があればそれを、なければ重複エラーを返す。
      card_array = cards.split
      card_error(card_array) || duplicate_error(card_array)
    end

  end

  # 入力値が文字列以外か？
  def class_error?(cards)
    true if cards.class != String
  end

  # カードが5枚以外か？
  def input_error?(cards)
    true if cards.split.length != 5
  end

  # カードが重複するか？
  def duplicate_error(card_array)
    ["カードが重複しています。"] if card_array.uniq.length != 5
  end

  # 不正なカードに対するエラー文を配列で出す。
  def card_error(card_array)
    error_msg_array = []
    card_array.each.with_index do |card, i|
      error_msg_array.push("#{i + 1}番目のカード指定文字が不正です。(#{card})") if card_error?(card)
    end
    error_msg_array.blank? ? nil : error_msg_array
  end

  # 不正なカードがあるか？
  def card_error?(card)
    true if card !~ CORRECT
  end



  module_function :search_errors, :input_error?, :class_error?, :duplicate_error, :card_error, :card_error?

end

