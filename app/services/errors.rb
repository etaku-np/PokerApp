
module Errors

  def search_errors(cards)

    card_array = cards.split

    if cards.blank? # 入力が空白だけか？
      ["カードを入力してください。"]
    elsif input_error?(card_array)
      ["5つのカード指定文字を半角スペース区切りで入力してください。"]
    else # 不正なカードに対するエラー文があればそれを、なければ重複エラーを返す。
      card_error(card_array) || duplicate_error(card_array)
    end

  end

  #未入力
  # def blank_error?(cards)
  #   cards.blank?
  # end

  # カードが5枚以外であるか？
  def input_error?(card_array)
    true if card_array.length != 5
  end

  # カードに重複があるか？
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
    true if card !~ /^([CDHS])([1-9]|1[0-3])$/
  end



  module_function :search_errors, :input_error?, :duplicate_error, :card_error, :card_error?

end

