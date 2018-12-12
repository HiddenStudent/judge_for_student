class TeacherAdminController < ApplicationController

  before_action :teacher
  before_action :activated


  def download_user
    SendToDropboxJob.set(wait: 5.seconds).perform_later(params[:id],params[:format])
    flash[:success] = "Answer was sent to Dropbox"
    redirect_to administration_path
  end

  def download_all
    SendToDropboxAllJob.set(wait: 5.seconds).perform_later(params[:id])
    flash[:success] = "Answers was sent to Dropbox"
    redirect_to administration_path
  end

  def check_answ
    @user = User.find_by_id(params[:id])
    @answer_id = @user.student_task_user(params[:format],params[:id])
    text = RestClient.get  "https://api.judge0.com/submissions/#{Answer.find(@answer_id.answer_id).content}?
                               base64_encoded=false&fields=status,language,time&page=4&per_page=2"
    @text = text.split(',')
  end
end