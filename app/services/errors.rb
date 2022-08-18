
module Errors

  def search_errors(cards)

    @carr = cards.split
    # @num_array_s = cards.delete("^0-9 ").split
    # #ナンバーを文字列から数値に変換して、並び替え
    # @num_array_i = @num_array_s.map(&:to_i).sort
    #
    # #入力が不正な要素を取得
    # @error_array = @carr.grep(/^0-9SHDC\s+/)


  end

  def blank_error?
    true if @carr.blank?
  end

  def input_error?
    true if @carr.length != 5
  end

  def duplicate_error?
    true if @carr.uniq.length != 5
  end

  # def number_error?
  #   @num_array_i.each do |i|
  #
  #   end
  #
  #   true if @num_array_i
  #
  # end

  def determine

    if blank_error?
      "カードを入力してください。"
    elsif input_error?
      "５枚のカードを入力してください。"
    elsif duplicate_error?
      "カードが重複しています。"
    # elsif !@error_array.empty?
    #   @error_array.each do |n|
    #     "#{@carr.find_index(n) + 1}番目の要素が不正です。（#{n}）"
    #   end
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
