class AnswController < ApplicationController

  before_action :logged_in_user
  before_action :activated


  def edit

  end

  def index

  end

  def update

  end

  def new

  end

  def show
    @users = Atask.first.users_in_task(params[:id])
    @answers = Studentanswer.where(task_id: params[:id])
    unless @answer.nil?
      @finals = @answer.finals
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
                               base64_encoded=false&fields=status,language,time&page=4&per_page=2"
    @text = text.split(',')
  end


  def create_answ
    CreateAnswerJob.set(wait: 5.seconds).perform_later(1)
    user = User.find(current_user.id)
    @test =user.studentanswers.find_by_task_id(params[:answ][:task_id])
    unless params[:answ][:content].blank?
      if params[:create] == 'Create'
        if @test.answer_id.nil?
          @answer = Answer.new(content:params[:answ][:content])
          if @answer.save
            @test.update_attributes(status: "In process", answer_id: @answer.id)
            @test.final = true if params[:answ][:final] == '1'
            @test.save
            flash[:success] = " Ur answer was creating"
            redirect_to root_path
          end
        else
          @answer = Answer.find(@test.answer_id)
          @answer.content = params[:answ][:content]
          if @answer.save
            @test.update_attributes(status: "In process")
            @test.final = true if params[:answ][:final] == '1'
            @test.save
            flash[:success] = "Ur answer was updating"
            redirect_to root_path
          end
        end
      else
        redirect_to answ_report_path(params[:answ][:content])
      end
    else
      flash[:danger] = 'Field can\'t be blank '
      render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    studentanswer =user.studentanswers.find_by_task_id(params[:format])
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


