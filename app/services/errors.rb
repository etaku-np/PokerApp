
module Errors

  def search_errors(cards)

    @carr = cards.split
    @suit = cards.delete("^A-z").split("")
    @num_array_s = cards.delete("^0-9 ").split
    @num_array_i = @num_array_s.map(&:to_i)

    @s_error = @suit.grep(/[^SHDC]/)
    @n_error = @num_array_i.select{ |i| i < 1 || i > 13 }

  end

  def blank_error?
    true if @carr.blank?
  end

  def input_error?
    true if @carr.length != 5 #|| @suit.length != @num_array_s.length
  end

  def duplicate_error?
    true if @carr.uniq.length != 5
  end


  def determine

    @s_err_msg = []
    @n_err_msg = []

    @n_error.each do |n|
      @n_err_msg << "#{@num_array_i.index(n)+1}番目のカードが不正です。 #{@carr[@num_array_i.index(n)]}"
    end
    @s_error.each do |n|
      @s_err_msg << "#{@suit.index(n)+1}番目のカードが不正です。 #{@carr[@suit.index(n)]}"
    end


    if blank_error?
      "カードを入力してください。"
    elsif input_error?
      "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    elsif duplicate_error?
      "カードが重複しています。"
    elsif @n_error.any? || @s_error.any?
      @n_err_msg.each do |x|
        #returnで返すと配列にならないけど、最初の一個しかでない。
        x
      end
    elsif @s_error.any?
      @s_err_msg.each do |x|
        x
      end
    end


  end


  module_function :search_errors, :blank_error?, :input_error?, :duplicate_error?, :determine

end

