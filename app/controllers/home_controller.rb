class HomeController < ApplicationController
  include PokerService

  def top; end

  def check
    cards = params[:cards]
    flash[:cards] = cards

    message = PokerService.judge_results(cards)
    flash[:message] = message.is_a?(Array) ? message.join("\n") : message

    redirect_to('/')
  end
end
