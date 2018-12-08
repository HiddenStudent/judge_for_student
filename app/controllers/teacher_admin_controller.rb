class TeacherAdminController < ApplicationController

  before_action :teacher
  before_action :activated

  def index

  end

  def new
    @users = User.all
  end

  def create_task
    @task = Atask.new(content:params[:teach][:content], id_lang:params[:teach][:id_lang])
    if @task.save
      flash[:success] = "Task was created"
      redirect_to administration_path
      #debugger
    else
      flash.now[:danger] = 'Invalid combination'
      render 'new'
    end
  end

  def tasks
    @tasks = Atask.all
    @answers = Answer.where(sending: true)
  end

  def edit
    #params.require(:id)
    @task = Atask.find(params[:id])
  end

  def tasks_progress
    @users = User.where(task_id: params[:task_id])
    @answers = Answer.where(task_id: params[:task_id])
  end

  def download_user
    SendToDropboxJob.set(wait: 5.seconds).perform_later(params[:id])
    flash[:success] = "All tasks were downloaded to DropBox, id: #{params[:id]}"
    redirect_to administration_path
  end

  def download_all
    SendToDropboxAllJob.set(wait: 5.seconds).perform_later(User.find_by_id(params[:id]).task_id)
    flash[:success] = "task id = #{User.find_by_id(params[:id]).task_id}"
    redirect_to administration_path
  end

  def check_answ
    answer_id = StudentsAnswer.where(task_id: params[:id])
    @answer_id = answer_id.find_by_user_id(current_user.id)
    @answer = Answer.find(@answer_id.answer_id)
    text = RestClient.get  "https://api.judge0.com/submissions/#{@answer.content}?
                               base64_encoded=false&fields=status,language,time&page=4&per_page=2"
    @text = text.split(',')
    @user = User.find_by_id(params[:id])
  end
end