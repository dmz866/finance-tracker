class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      #render json: @stock
      
      if @stock 
        #render partial: 'users/result'
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else  
        flash[:danger] = "Ticker not found"
        redirect_to my_portfolio_path
      end
    else
      flash[:danger] = "Enter ticker"
      render 'users/my_portfolio'
    end
  end
end