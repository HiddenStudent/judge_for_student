class TeacherAdminController < ApplicationController

  before_action :teacher
  before_action :activated


  def download_user
    SendToDropboxJob.set(wait: 5.seconds).perform_later(params[:id],params[:format])
    redirect_to administration_path
  end

  def download_all
    SendToDropboxAllJob.set(wait: 5.seconds).perform_later(params[:id])
    redirect_to administration_path
  end

  def check_answ
    answer_id = Studentanswer.where(task_id: params[:format])
    @answer_id = answer_id.find_by_user_id(params[:id])
    @answer = Answer.find(@answer_id.answer_id)
    text = RestClient.get  "https://api.judge0.com/submissions/#{@answer.content}?
                               base64_encoded=false&fields=status,language,time&page=4&per_page=2"
    @text = text.split(',')
    @user = User.find_by_id(params[:id])
  end
end