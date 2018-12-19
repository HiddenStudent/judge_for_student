class AnswController < ApplicationController

  before_action :logged_in_user
  before_action :activated
  before_action :teacher, only: [:destroy]
  def show
    @finals = nil
    @users = User.where("id IN (SELECT user_id  FROM group_users
                          WHERE group_id = #{params[:group_id]})")
    @answers = Answer.where(task_id: params[:id])
    @answers_complete = Answer.where(task_id: params[:id], status: 'complete')
    @finals = true unless @answers_complete.find_by_final(true).nil?
  end

  def show_report
    @code = params[:test]
    res = RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                           {language_id: '4', source_code: "#{@code}"}
    res = JSON.parse(res) # Parsing JSON file
    text = RestClient.get "https://api.judge0.com/submissions/#{res['token']}?
                            #{judge_params} "
    @text = text.split(',')
  end

  def create_answ
    if params[:answ][:content].blank?
      flash[:danger] = 'Field can\'t be blank'
      redirect_to new_answ_url(params[:answ][:task_id])
    else
      if params[:create] == 'Create'
        answer = Answer.new(user_id: current_user.id, task_id: params[:answ][:task_id],text: params[:answ][:content], status: 'In process', final: params[:answ][:final])
        answer.save
        flash[:success] = 'Ur answer was created'
        redirect_to root_path
      else
        redirect_to answ_report_path(params[:answ][:text])
      end
    end
  end

  def destroy
    Answer.where(task_id: params[:format], user_id: params[:id]).delete_all
    redirect_to answ_path(params[:format])
  end
end


