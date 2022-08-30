class HomeController < ApplicationController

  include Hands
  include Errors

  def top
  end

  def check
    cards = params[:cards]
    flash[:cards] = cards

    # エラーメッセージがあればそれを、なければ（何かの役になっているはずなので）役の判定を出す。
    message = Errors.search_errors(cards) || Hands.search_hands(cards)[:name]

    # （特にエラーメッセージが）配列になっている場合は改行して出す。そうでなければそのまま。
    flash[:message] = message.is_a?(Array) ? message.join("\n") : message

    redirect_to("/")
  end

end
