class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit_feedback
    params[:feedback][:content] = "no comment" if params[:feedback][:content].blank?
    if params[:rework] == 'rework'
      redirect_to  users_rework_path(params[:id],params[:feedback][:content])
    elsif params[:complete] == 'complete'
      redirect_to  users_complete_path(params[:id],params[:feedback][:content])
    else
      redirect_to administration_path
    end
  end

  def edit_complete
    @user = User.find_by_id(params[:id])
    @answer = Answer.find_by_user_id(params[:id])
    @user.status = "complete"
    #@user.save
    if @user.save
      StudentMailer.info_status(@user,params[:text]).deliver_now
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
    @answer.final = false
    @answer.save
    @user.save
    StudentMailer.info_status(@user,params[:text]).deliver_now
    flash[:success] = "Email about changes was sent to student."
    redirect_to administration_path
    #else
    #flash[:danger] = "something went wrong"
    #redirect_to administration_path
    #end
  end

  def update_task_id
    alltask =  StudentsAnswer.where(task_id: params[:task_id])
    unless alltask.nil?
      if alltask.find_by_user_id(params[:id]).nil?
        @students_answ = StudentsAnswer.new do |u|
        u.task_id = params[:task_id]
        u.user_id = params[:id]
        end
        if @students_answ.save
          flash[:success] = "Student was added"
          redirect_to edit_atask_url(params[:task_id])
        end
      else
        flash[:danger] = "This student already added"
        redirect_to edit_atask_url(params[:task_id])

      end
    else
      @students_answ = StudentsAnswer.new do |u|
      u.task_id = params[:task_id]
      u.user_id = params[:id]
      end
      if @students_answ.save
        flash[:success] = "Student was added"
        redirect_to edit_atask_url(params[:task_id])

      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to index_user_path
  end

  def new
    unless current_user.nil?
      if current_user.teacher == true
        @user = User.new
      else
        flash[:success] = "No permissions"
        redirect_to root_path
      end
    else
      flash[:success] = "No permissions"
      redirect_to root_path
    end
  end


  def create
    if current_user.teacher == true
      @user = User.new(user_params)
      token = @user.new_token
      @user.activation_digest = token
      if @user.save
        StudentMailer.activation(@user).deliver_now
        #UserMailer.account_activation(@user).deliver_now
        flash[:info] = "Email for user was sent."
        redirect_to administration_path
      else
        render 'new'
      end
    end
  end

  def update

    unless  params[:user][:picture].nil?
      @user = current_user.update user_avatar
      #if @user.save
      flash[:success] = "Avatar was uploaded!"
      redirect_to root_path
    else
      flash[:danger] = "Please choose the file..."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end

  private

  def user_avatar
    params.require(:user).permit(:picture)
  end

end
