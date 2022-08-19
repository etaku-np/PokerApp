
module Errors

  def search_errors(cards)

    @carr = cards.split
    @suit = cards.delete("^SHDC")
    @num_array_s = cards.delete("^0-9 ").split
    @num_array_i = @num_array_s.map(&:to_i).sort

  end

  def blank_error?
    true if @carr.blank?
  end

  def input_error?
    true if @carr.length != 5 || @suit.length != @num_array_s.length
  end

  def duplicate_error?
    true if @carr.uniq.length != 5
  end


  def determine

    if blank_error?
      "カードを入力してください。"
    elsif input_error?
      "５枚のカードを正しく入力してください。"
    elsif duplicate_error?
      "カードが重複しています。"
    elsif @num_array_i.select{ |a| a < 1 || a > 13 }.any?
      "ナンバーは 1 から 13 で入力してください。"

    end

  end


  module_function :search_errors, :blank_error?, :input_error?, :duplicate_error?, :determine

end

# @suit_array = cards.delete("^SHDC ").split
# @num_array_s = cards.delete("^0-9 ").split
# @num_array_i = @num_array_s.map(&:to_i).sort
# @ch = (1..cards.length).zip(cards).to_h
# n_error =
# @num_array_i.filter_map.with_index do |num, idx|
#     idx + 1 if num < 1 || num > 13
#   end
# s_error =
# @suit_array.filter_map.with_index do |su, idx|
#     idx + 1 if su.length > 1
#   end
