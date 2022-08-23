
module Errors

  def search_errors(cards)

    @carr = cards.split
    @suit = cards.delete("^A-z").split("")
    @num_array_s = cards.delete("^0-9 ").split
    @num_array_i = @num_array_s.map(&:to_i)
    @error_num = @num_array_i.select{ |i| i < 1 || i > 13 }
    @error_suit = @suit.grep(/[^SHDC]/)
    @card_hash = (1..@carr.length).zip(@carr).to_h

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

  def suit_error
    @s_error_msg = []

    if @error_suit.any?
      @error_suit.each do |v|
        id = @suit.find_index(v)+1
        # binding.pry
        @s_error_msg << "#{id}枚目のスートが不正です。#{@carr[id-1]}"
      end
    end

    @s_error_msg
  end

  def num_error
    @n_error_msg = []

    if @error_num.any?
      @error_num.each do |v|
        id = @num_array_i.find_index(v)+1
        @n_error_msg << "#{id}枚目のナンバーが不正です。#{@carr[id - 1]}"
      end
    end

    @n_error_msg
  end


  def determine


    # binding.pry

    if blank_error?
      "カードを入力してください。"
    elsif input_error?
      "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    elsif duplicate_error?
      "カードが重複しています。"
    elsif suit_error.any?
      @s_error_msg.join("\n")
    elsif num_error.any?
      @n_error_msg.join("\n")
    end


    # binding.pry

  end


  module_function :search_errors, :blank_error?, :input_error?, :duplicate_error?, :determine, :suit_error, :num_error

end

