class UsersController < ApplicationController

  before_action :activated
  before_action :logged_in_user
  before_action :teacher, except: [:update]


  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def edit_feedback
    params[:feedback][:content] = 'no comment' if params[:feedback][:content].blank?
    if params[:rework] == 'rework'
      redirect_to users_rework_path(params[:id], params[:feedback][:content], params[:task_id])
    elsif params[:complete] == 'complete'
      redirect_to users_complete_path(params[:id], params[:feedback][:content], params[:task_id])
    end
  end

  def edit_complete
    answer = Answer.where(user_id: params[:id], task_id: params[:task_id]).first
    answer.update_attributes(status: 'complete')
    answer.save
    StudentMailer.info_status(User.find(params[:id]), params[:text], answer).deliver_now
    flash[:success] = 'Email about changes was sent to student'
    redirect_to administration_path
  end

  def edit_rework
    answer = Answer.where(user_id: params[:id], task_id: params[:task_id]).first
    answer.update_attributes(status: 'rework', sending: 'false', final: 'false', content: nil, text: nil)
    answer.save
    StudentMailer.info_status(User.find(params[:id]), params[:text], answer).deliver_now
    flash[:success] = 'Email about changes was sent to student.'
    redirect_to administration_path
  end

  def update_task_id
    if Answer.where(task_id: params[:task_id], user_id: params[:id]).first.nil?
      students_answ = Answer.new(task_id: params[:task_id], user_id: params[:id])
      students_answ.save
      flash[:success] = 'Student was added'
      redirect_to edit_task_url(params[:task_id])
      StudentMailer.new_task_notify(User.find(params[:id]),
                        Task.find(params[:task_id])).deliver_now
    else
      flash[:danger] = 'This student already added'
      redirect_to edit_task_url(params[:task_id])
    end
  end

  def destroy
    if User.find(params[:id]).teacher?
      flash[:danger] = 'U have no permissions'
      redirect_to root_path
    else
      User.find(params[:id]).destroy
      flash[:danger] = 'User was deleted'
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    @user.generate_activation_digest!

    if @user.save
      StudentMailer.activation(@user).deliver_now
      flash[:info] = 'Email for user was sent.'
      redirect_to administration_path
    else
      render 'new'
    end
  end

  def update
    if params[:user][:picture].nil?
      flash[:danger] = 'Please choose the file...'
      redirect_to root_path
    else
      @user = current_user.update user_avatar
      flash[:success] = 'Avatar was uploaded!'
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
