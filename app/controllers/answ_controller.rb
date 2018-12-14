class AnswController < ApplicationController

  before_action :logged_in_user
  before_action :activated

  def new
  end

  def show
    @users = Task.first.users_in_task(params[:id])
    @answers = StudentAnswer.where(task_id: params[:id])
    unless @answers.find_by_final(true).nil?
      @finals = true
    else
      @finals = nil
    end
  end

  def show_report
    @code = params[:test]
    res =  RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                           {language_id: '4', source_code: "#{@code}"}
    res = JSON.parse(res)    #  Parsing JSON file
    text = RestClient.get  "https://api.judge0.com/submissions/#{res["token"]}?
                            #{judge_params} "
    @text = text.split(',')
  end


  def create_answ
    @test = User.first.student_task_user(params[:answ][:task_id], current_user.id)
    unless params[:answ][:content].blank?
      if params[:create] == 'Create'
        if @test.answer_id.nil?
          puts "1"
          @answer = Answer.new(text: params[:answ][:content],content: params[:answ][:content] )
          puts "2"
          @answer.save
          puts "3"
        else
          puts "4"
          @answer = Answer.find(@test.answer_id).update_attributes(text: params[:answ][:content], content: params[:answ][:content])
          puts "5"
          @answer.save
          puts "6"
        end
        @test.update_attributes(status: "In process", answer_id: @answer.id, final: params[:answ][:final])
        @test.save
        flash[:success] = " Ur answer was created"
        redirect_to root_path
        else
          redirect_to answ_report_path(params[:answ][:content])
      end
    else
      flash[:danger] = 'Field can\'t be blank '
      redirect_to new_answ_url(params[:answ][:task_id])
    end
    CreateAnswerJob.set(wait: 5.seconds).perform_later(1)
  end

  def destroy
    studentanswer = User.first.student_task_user(params[:format],params[:id])
    Answer.find(studentanswer.answer_id).destroy unless studentanswer.answer_id.nil?
    studentanswer.destroy
    studentanswer.save
    redirect_to answ_path(params[:format])
  end

  private

  def group_params
    params.require(:answer).permit(:content)
  end

end


