class HomeController < ApplicationController
  include PokerService

  def top
  end

  def check
    cards = params[:cards]
    flash[:cards] = cards

    message = PokerService.webapp(cards)

    # 配列になっている場合は改行して出す。そうでなければそのまま。
    flash[:message] = message.is_a?(Array) ? message.join("\n") : message

    redirect_to("/")
  end
end