class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end
  
  def my_friends
    @friendships = current_user.friends
  end
  
  def search
    if params[:search_param].blank?
      flash[:danger] = "Enter a name or email"  
    else
      @users = User.search(params[:search_param])
      @users = current_user.except_current_user(@users)
      flash[:danger] = "Friend not found" if @users.count <= 0 
    end
    
    respond_to do |format|
      format.js { render partial: 'friends/result' }
    end
  end
end