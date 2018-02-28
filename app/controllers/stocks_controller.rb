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
        respond_to do |format|
          flash.now[:danger] = "Ticker not found"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:danger] = "Enter ticker"
        format.js { render partial: 'users/result' }
      end
    end
  end
end