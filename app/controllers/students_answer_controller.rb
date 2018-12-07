class StudentsAnswerController < ApplicationController

  def new
    @students = StudentsAnswer.new
  end

  def create

  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def students_params
    params.require(:students_answer).permit(:user_id, :task_id)
  end
end
