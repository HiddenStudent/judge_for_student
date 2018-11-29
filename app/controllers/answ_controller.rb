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


    CreateAnswerJob.set(wait: 5.seconds).perform_later(1)

   # @users = User.where(activated: true).paginate(page: params[:page])
    @test = Answer.find_by_user_id(current_user.id)


    unless params[:answ][:content].blank?

   #   CreateAnswerJob.set(wait: 5.seconds).perform_later(@test,params[:answ][:content])

      if @test.nil?
        @answer = Answer.new(content:params[:answ][:content],user_id:current_user.id,
                             task_id:current_user.task_id, sending:false )

        if @answer.save
          flash[:success] = " Ur answer was creating"
        end

      else

        @test.content = params[:answ][:content]
        @test.sending = false

        if @test.save
          flash[:success] = " Answer was updating"
          end
        end
     # Answer.delay.create_answ(@test,params[:answ][:content])

      redirect_to root_path

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