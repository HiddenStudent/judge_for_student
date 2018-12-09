class AtasksController < ApplicationController

  before_action :logged_in_user
  before_action :teacher, only: [:create,:update,:edit,:new]
  before_action :activated

  def new
    @task = Atask.new
  end

  def index

  end

  def create
    @task = Atask.new(task_params)
    if @task.save
      @tasks_group = TasksGroup.new do |u|
        u.task_id = @task.id
        u.group_id = params[:atask][:group_id]
      end
      @tasks_group.save
      flash[:success] = "Task was created"
      redirect_to group_url(params[:atask][:group_id])
    end
  end

  def edit
    @task = Atask.find(params[:id])
    @users = User.all
  end

  def update
    @task = Atask.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Task updated"
      redirect_to administration_tasks_path
    else
      render 'edit'
    end
  end

  def show
    @task = Atask.find(params[:id])
    test = StudentsAnswer.where(user_id: current_user.id)
    test = test.find_by_task_id(params[:id])
    @studentsanswer = test
    unless test.nil?
      @final = test.final
    end
  end

  def destroy
    group = TasksGroup.find_by_task_id(params[:id]).group_id
    Atask.find(params[:id]).destroy
    puts "TASK WAS DELETED"
    TasksGroup.find_by_task_id(params[:id]).destroy
    puts "TASKSGROUP WAS DELETED"
    studentanswer = StudentsAnswer.where(task_id: params[:id])
    answer = Answer.all
    studentanswer.each do |s|
      answer.each do |a|
        if s.answer_id == a.id
          puts "==========delete Answer a.destroy, id = #{a.id}, s.id = #{s.id}"
          a.destroy
          a.save
        end
      end
      puts "======= delete StudentsAnswer = #{s.id}"
      s.destroy
      s.save
    end
    redirect_to group_path(group)
  end


  private

  def task_params
    params.require(:atask).permit(:name, :content)
  end
end
