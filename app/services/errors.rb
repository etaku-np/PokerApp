
module Errors

  def search_errors(cards)

    card_array = cards.split

    if blank_error?(cards)
      ["カードを入力してください。"]
    elsif input_error?(card_array)
      ["5つのカード指定文字を半角スペース区切りで入力してください。"]
    else
      card_error(card_array) || duplicate_error(card_array)
    end

  end

  #未入力
  def blank_error?(cards)
    cards.blank?
  end

  #5枚以外
  def input_error?(card_array)
    true if card_array.length != 5
  end

  #重複
  def duplicate_error(card_array)
    ["カードが重複しています。"] if card_array.uniq.length != 5
  end

  # def suit_error
  #   @s_error_msg = []
  #
  #   if @error_suit.any?
  #     @error_suit.each do |v|
  #       id = @suit.find_index(v)+1
  #       # binding.pry
  #       @s_error_msg << "#{id}枚目のスートが不正です。#{@carr[id-1]}"
  #     end
  #   end
  #
  #   @s_error_msg
  # end
  #
  # def num_error
  #   @n_error_msg = []
  #
  #   if @error_num.any?
  #     @error_num.each do |v|
  #       id = @num_array_i.find_index(v)+1
  #       @n_error_msg << "#{id}枚目のナンバーが不正です。#{@carr[id - 1]}"
  #     end
  #   end
  #
  #   @n_error_msg
  # end


  def card_error(card_array)
    error_msg_array = []
    card_array.each.with_index do |card, i|
      error_msg_array.push("#{i + 1}番目のカード指定文字が不正です。(#{card})") if card_error?(card)
    end
    error_msg_array.blank? ? nil : error_msg_array
  end

  #カード不正
  def card_error?(card)
    true if card !~ /^([CDHS])([1-9]|1[0-3])$/
  end



  module_function :search_errors, :blank_error?, :input_error?, :duplicate_error, :card_error, :card_error?

end

