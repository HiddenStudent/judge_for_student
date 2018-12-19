class TeacherAdminController < ApplicationController
  before_action :logged_in_user
  before_action :teacher
  before_action :activated


  def download_user
    SendToDropboxJob.set(wait: 5.seconds).perform_later(params[:id], params[:format])
    flash[:success] = 'Answer was sent to Dropbox'
    redirect_to administration_path
  end

  def download_all
    SendToDropboxAllJob.set(wait: 5.seconds).perform_later(params[:id])
    flash[:success] = 'Answers was sent to Dropbox'
    redirect_to administration_path
  end

  def check_answ
    @user = User.find_by_id(params[:id])
    @answer = Answer.where(task_id: params[:format], user_id: params[:id]).last
    text = RestClient.get "https://api.judge0.com/submissions/#{@answer.content}?
                            #{judge_params}"
    @text = text.split(',')
  end
end