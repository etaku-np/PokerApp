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
    #message =
    # flash[:message] = "#{Errors.determine}" || "#{Hands.judge}"
    if Errors.determine != nil
      flash[:message] = "#{Errors.determine}"
    else
      flash[:message] = "#{Hands.judge}"
    end

    redirect_to("/")

  end


end
