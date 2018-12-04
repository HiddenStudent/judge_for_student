class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def edit_complete
  @user = User.find_by_id(params[:id])
  @answer = Answer.find_by_user_id(params[:id])

  @user.status = "complete"
    #@user.save
  if @user.save
    flash[:success] = "Success, user: #{@user.email}"
    redirect_to administration_path
    else
      flash[:danger] = "something went wrong"
      redirect_to administration_path
    end
  end

  def edit_rework
    @user = User.find_by_id(params[:id])
    @answer = Answer.find_by_user_id(params[:id])

    @user.status = "rework"
    @answer.sending = false
    @answer.content = nil
    @answer.save
    @user.save

        flash[:success] = "Success, user: #{@user.email}, answer: #{@answer.id}, #{@answer.sending} params: #{params[:id]}"
    redirect_to administration_path
 # else
   # flash[:danger] = "something went wrong"
   # redirect_to administration_path
  #end
  end

  def update_task_id
    @user = User.find(params[:id])
    @user.task_id = params[:task_id]
    if @user.save

    else

   flash[:danger]= "wowowoowwowowowow"
    end
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
