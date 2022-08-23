class HomeController < ApplicationController

  # require_relative '../services/errors'
  # require_relative '../services/hands'
  include Hands
  include Errors

  def top
  end

  def check
    cards = params[:cards]
    flash[:cards] = cards

    message = Errors.search_errors(cards) || Hands.search_hands(cards)[:name]
    flash[:message] = message.is_a?(Array) ? message.join("\n") : message

    redirect_to("/")
  end

end
