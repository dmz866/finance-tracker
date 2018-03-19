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
      flash.now[:danger] = "Enter a name or email"  
    else
      @users = User.search(params[:search_param])
      @users = current_user.except_current_user(@users)
      flash.now[:danger] = "Friend not found" if @users.count <= 0 
    end
    
    respond_to do |format|
      format.js { render partial: 'friends/result' }
    end
  end
  
  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:success] = "Friend added"
    else
      flash[:danger] = "Something went wrong"
    end
    redirect_to my_friends_path
  end
end