class HomeController < ApplicationController


  # require_relative '../services/errors'
  # require_relative '../services/hands'
  include Hands
  include Errors

  def top
  end


  def check
    cards = params[:cards]
    Errors.search_errors(cards)
    Hands.search_hands(cards)

    if Errors.determine != nil
      flash[:message] = "#{Errors.determine}"
    else
      flash[:message] = "#{Hands.judge}"
    end
    flash[:cards] = "#{params[:cards]} "

    redirect_to("/")
    # render "home/top"
  end


end
