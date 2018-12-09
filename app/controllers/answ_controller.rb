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
    @users = []
    ids = StudentsAnswer.where(task_id: params[:id])
    users = User.all
    ids.each do |i|
      users.each do |u|
        if i.user_id == u.id
          @users += [u]
        end
      end
    end
    @answers = StudentsAnswer.where(task_id: params[:id])
  end

  def show_report
    testt = params[:test]
    puts "============#{testt}"
    @code = testt
    res =  RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                           {language_id: '4', source_code: "#{testt}"}
    res = JSON.parse(res)    #  Parsing JSON file
    res = res["token"]
    text = RestClient.get  "https://api.judge0.com/submissions/#{res}?
                               base64_encoded=false&fields=status,language,time&page=4&per_page=2"
    @text = text.split(',')
  end


  def create_answ
    CreateAnswerJob.set(wait: 5.seconds).perform_later(1)
    test = StudentsAnswer.where(user_id: current_user.id)
    @test = test.find_by_task_id(params[:answ][:task_id])
    unless params[:answ][:content].blank?
      if params[:create] == 'Create'
        if @test.answer_id.nil?
          @answer = Answer.new(content:params[:answ][:content])
          if @answer.save
            @test.update_attributes(status: "In process", answer_id: @answer.id)
            if params[:answ][:final] == '1'
              @test.final = true
            end
            @test.save
            flash[:success] = " Ur answer was creating"
            redirect_to root_path
          end
        else
          @answer = Answer.find(@test.answer_id)
          @answer.content = params[:answ][:content]
          if @answer.save
            @test.update_attributes(status: "In process")
            if params[:answ][:final] == '1'
              @test.final = true
            end
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
    puts "===================#{params}"
    studentanswer = StudentsAnswer.where(task_id: params[:format])
    studentanswer = studentanswer.find_by_user_id(params[:id])
    Answer.find(studentanswer.answer_id).destroy unless studentanswer.answer_id.nil?
    studentanswer.destroy
    studentanswer.save
    redirect_to answ_path(params[:format])
  end

  private

  def group_params
    params.require(:answer).permit(:content)
  end

    #redirect_to url_with_protocol("google.com")
    #AnswController.do_it

end



#  res = RestClient.get 'https://api.judge0.com/languages'
#  puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"
#  puts res
#  puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"

#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\n\", name);\n  return 0;\n}