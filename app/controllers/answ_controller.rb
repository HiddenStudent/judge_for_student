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

    @answer = Answer.new(content:params[:answ][:content])

    unless @answer.content.blank?


      res = RestClient.get 'https://api.judge0.com/languages'
      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"
      puts res
      puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"


  #include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\n\", name);\n  return 0;\n}



      res =  RestClient.post 'https://api.judge0.com/submissions/?base64_encoded=false&wait=false/',
                    {language_id: '4', source_code: "#{@answer.content}"}

       @answer.content = res
    if @answer.save
       flash[:success] = "Answer was send and save to data"
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
