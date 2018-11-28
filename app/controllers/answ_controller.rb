class AnswController < ApplicationController
  def new

  end

  def edit

  end

  def index

  end

  def show

  end

  def update

  end

  def destroy

  end

  def create_answ

    @test = Answer.find_by_user_id(current_user.id)






   # @answer = Answer.new(content:params[:answ][:content])

    unless params[:answ][:content].blank?


      res = RestClient.get 'https://api.judge0.com/languages'
      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"
      puts res
      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"


  #include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\n\", name);\n  return 0;\n}



      res =  RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                    {language_id: '4', source_code: "#{params[:answ][:content]}"}

      if @test.nil?
        @answer = Answer.new(content:res,user_id:current_user.id,task_id:current_user.task_id )
    if @answer.save
       flash[:success] = "Ur answer was creating"
    end

      else
        @test.content = res
        if @test.save
          flash[:success] = "Answer was updating"
        end
        end
      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"

      puts res

      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"

     # end

      redirect_to root_path
      #debugger
    else
      flash[:danger] = 'Field can\'t be blank '
      render 'new'
      end
    end
  end
#end
