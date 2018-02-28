class StocksController < ApplicationController
  def search
    #render json: @stock
    #if params[:stock].present?
    #render partial: 'users/result'
    if params[:stock].blank?
      flash.now[:danger] = "Enter ticker"
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "Ticker not found" unless @stock
    end
    
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
end