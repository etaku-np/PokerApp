module ErrorService
  # 入力されたカードの不正な入力を判定するモジュールです
  CORRECT =/^([SHDC])([1-9]|1[0-3])$/

  def validate_cards(cards)
    if cards.blank?
      ["カードを入力してください。"]
    elsif class_error?(cards)
      ["文字列を入力してください。"]
    else
      card_array = cards.split
      input_error(card_array) || incorrect_card_error(card_array) || duplicate_error(card_array)
    end
  end

  def class_error?(cards)
    true if cards.class != String
  end

  def input_error(card_array)
    ["5つのカード指定文字を半角スペース区切りで入力してください。"] if card_array.length != 5
  end

  def duplicate_error(card_array)
    ["カードが重複しています。"] if card_array.uniq.length != 5
  end

  def incorrect_card_error(card_array)
    error_msg_array = []
    card_array.each.with_index do |card, i|
      error_msg_array.push("#{i + 1}番目のカード指定文字が不正です。(#{card})") if incorrect_card_error?(card)
    end
    error_msg_array.blank? ? nil : error_msg_array
  end

  def incorrect_card_error?(card)
    true if card !~ CORRECT
  end

  module_function :validate_cards, :input_error, :class_error?, :duplicate_error, :incorrect_card_error, :incorrect_card_error?
end

