class TeacherAdminController < ApplicationController

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
    @answer = Answer.find_by_user_id(params[:id])
    text = RestClient.get  "https://api.judge0.com/submissions/#{@answer.content}?
                                 base64_encoded=false&fields=stdout,stderr,status_id,
                                      language_id,time,compile_output"
    @text = text.split(',')
    #SendToDropboxJob.set(wait: 0.seconds).perform_later(params[:id])
     @user = User.find_by_id(params[:id])
     #flash[:success] = col
  end
end