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
    StudentMailer.info_status(@user).deliver_now

    flash[:success] = "Email about changes was sent to student"
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

    StudentMailer.info_status(@user).deliver_now


        flash[:success] = "Email about changes was sent to student."
    redirect_to administration_path
 # else
   # flash[:danger] = "something went wrong"
   # redirect_to administration_path
  #end
  end

  def update_task_id
    @user = User.find(params[:id])
    #if @user.status == "complete"
    @user.task_id = params[:task_id]
    StudentMailer.new_task_notify(@user).deliver_now
    @user.status = "In process"
    @answer = Answer.find_by_user_id(@user.id)

    if @user.save
      unless @answer.nil?
        @answer.destroy
        @answer.save
      end

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
