class UsersController < ApplicationController

  def index
    @users = User.all
  end




 def destroy
  User.find(params[:id]).destroy
  flash[:success] = "User deleted"
  # if ($checker == true)

  redirect_to index_user_path
  #   else

  # redirect_to followers_user_path(@user.find(session[:user_id]))
  #  end
  end
end
