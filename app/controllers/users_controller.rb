class UsersController < ApplicationController

  before_action :activated
  before_action :logged_in_user
  before_action :teacher , except: [:update]

  def index
    @users = User.all
  end

  def edit_feedback
    params[:feedback][:content] = "no comment" if params[:feedback][:content].blank?
    if params[:rework] == 'rework'
      redirect_to  users_rework_path(params[:id],params[:feedback][:content],params[:feedback][:ans_id])
    elsif params[:complete] == 'complete'
      redirect_to  users_complete_path(params[:id],params[:feedback][:content],params[:feedback][:ans_id])
    else
      redirect_to administration_path
    end
  end

  def edit_complete
    @user = User.find(params[:id])
    @answer = Studentanswer.find(params[:ans_id])
    @answer.status = "complete"
    if @answer.save
      StudentMailer.info_status(@user,params[:text],@answer).deliver_now
      flash[:success] = "Email about changes was sent to student"
      redirect_to administration_path
    else
      flash[:danger] = "something went wrong"
      redirect_to administration_path
    end
  end

  def edit_rework
    @user = User.find(params[:id])
    @answer = Studentanswer.find(params[:ans_id])
    @answer.status = "rework"
    @answer.sending = false
    ans = Answer.find(@answer.answer_id)
    ans.destroy
    ans.save
    @answer.final = false
    @answer.answer_id = nil
    if @answer.save
     # StudentMailer.info_status(@user,params[:text],@answer).deliver_now
      flash[:success] = "Email about changes was sent to student."
      redirect_to administration_path
    else
      flash[:danger] = "something went wrong"
      redirect_to administration_path
    end
  end

  def update_task_id
    unless User.find(params[:id]).studentanswers.nil?
      if User.find(params[:id]).studentanswers.find_by_task_id(params[:task_id]).nil?
        @students_answ = Studentanswer.new do |u|
          u.task_id = params[:task_id]
          u.user_id = params[:id]
          u.save
        end
          @students_answ.save
          user = User.find(params[:id])
          user.studentanswer_id = @students_answ.id
          user.save
          StudentMailer.new_task_notify(User.find(params[:id]),
                                        Atask.find(params[:task_id])).deliver_now
          flash[:success] = "Student was added"
          redirect_to edit_atask_url(params[:task_id])
      else
        flash[:danger] = "This student already added"
        redirect_to edit_atask_url(params[:task_id])
      end
    else
      @students_answ = Studentanswer.new do |u|
        u.task_id = params[:task_id]
        u.user_id = params[:id]
        u.save
      end
        @students_answ.save
        user = User.find(params[:id])
        user.studentanswer_id = @students_answ.id
        user.save

        StudentMailer.new_task_notify(User.find(params[:id]),
                                      Atask.find(params[:task_id])).deliver_now
        flash[:success] = "Student was added"
        redirect_to edit_atask_url(params[:task_id])
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
