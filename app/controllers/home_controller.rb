class HomeController < ApplicationController
  def top
  end

  def check
    #入力を受け取る
    @cards = params[:cards]

    #受け取ったカードを、スートとナンバーに分ける
    @suit = @cards.delete("^A-Z| ").split
    @num = @cards.delete("^0-9| ").split


    #エラー判定
    if @cards.split("").count(" ") != 4
      flash[:error] = "カードは半角スペースで区切ってください。"
    elsif @cards.split(" ").count != 5
      flash[:error] = "カードは５枚分入力してください。"
    elsif @cards.split(" ").uniq.count != 5
      flash[:error] = "カードが重複しています。"
    elsif @suit.count != 5
      flash[:error] = "スートは５枚分入力してください。"
    elsif @cards.split.grep(/[A-Z]/).count != 5
      flash[:error] = "スートは大文字で入力してください。"
    elsif @cards.split.grep(/[SHDC]/).count != 5
      flash[:error] = "スートはS, H, D, Cで入力してください。"
    elsif @num.count != 5
      flash[:error] = "ナンバーは５枚分入力してください。"
    elsif @num.reject { |n| n.to_i > 14 && n.to_i < 0 }.count != 5
      flash[:error] = "ナンバーは1から13で入力してください。"
    end


    #ナンバーを文字列から数値に変換して、並び替え
    @num.map!(&:to_i).sort_by!{|x| x.to_i }

    flush = 0
    straight = 0

    #フラッシュの役判定
    if @suit.uniq.length == 1
      flush = 1
    end

    #ストレートの役判定
    if @num[1] == @num[0] + 1 && @num[2] == @num[0] + 2 && @num[3] == @num[0] + 3 && @num[4] == @num[0] + 4 || @num == [1,10,11,12,13]
      straight = 1
    end

    #とりあえず空の配列を作る
    @card_set = []

    #カードの組み合わせを配列で表示する。
    (0..@num.uniq.length - 1).each do |n|
      @card_set[n] = @num.count(@num.uniq[n])
      @card_set.sort!
    end

    #最終判定
    if flush == 1 && straight == 1
      flash[:result] = "ストレートフラッシュ"
    elsif flush == 1
      flash[:result] = "フラッシュ"
    elsif straight == 1
      flash[:result] = "ストレート"
    elsif @card_set == [1, 4]
      flash[:result] = "フォーカード"
    elsif @card_set == [2, 3]
      flash[:result] = "フルハウス"
    elsif @card_set == [1, 1, 3]
      flash[:result] = "スリーカード"
    elsif @card_set == [1, 2, 2]
      flash[:result] = "ツーペア"
    elsif @card_set == [1, 1, 1, 2]
      flash[:result] = "ワンペア"
    elsif
      flash[:result] = "ハイカード"
    end


    redirect_to("/")
  end


end
