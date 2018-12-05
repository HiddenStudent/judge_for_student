class AnswController < ApplicationController
  def new
    test = Answer.find_by_user_id(current_user.id)
    unless test.nil?
      @final = test.final
    else
      @final = false
    end
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




  def self.do_it


  end




  def create_answ

    #redirect_to url_with_protocol("google.com")
    #AnswController.do_it


    CreateAnswerJob.set(wait: 5.seconds).perform_later(1)

    @test = Answer.find_by_user_id(current_user.id)


    unless params[:answ][:content].blank?

   #   CreateAnswerJob.set(wait: 5.seconds).perform_later(@test,params[:answ][:content])

      if @test.nil?
        @answer = Answer.new(content:params[:answ][:content],user_id:current_user.id,
                             task_id:current_user.task_id, sending:false )

        if params[:answ][:final] == '1'
          @answer.final = true
        end


        if @answer.save
          current_user.status = "In process"
          current_user.save
          flash[:success] = " Ur answer was creating"
        end

      else

        @test.content = params[:answ][:content]
        @test.sending = false

        if params[:answ][:final] == '1'
          @test.final = true
        end

        if @test.save
          current_user.status = "In process"
          current_user.save
          flash[:success] = " Answer was updating"
          end
        end
     # Answer.delay.create_answ(@test,params[:answ][:content])

       redirect_to root_path
     # redirect_to url_with_protocol("google.com")
    else
      flash[:danger] = 'Field can\'t be blank '
      render 'new'
    end
    end
end





#  res = RestClient.get 'https://api.judge0.com/languages'
#  puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"
#  puts res
#  puts "--------------------------------------------------------------------------------------------------------------------------------------------------------------"

#include <stdio.h>\n\nint main(void) {\n  char name[10];\n  scanf(\"%s\", name);\n  printf(\"hello, %s\n\", name);\n  return 0;\n}