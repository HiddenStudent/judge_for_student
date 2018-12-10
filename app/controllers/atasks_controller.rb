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
    task = Atask.new(task_params)
    if task.save
      tasks_group = Taskgroup.new do |u|
        u.task_id = task.id
        u.group_id = params[:atask][:group_id]
      end
      tasks_group.save
      task.taskgroup_id = tasks_group.id
      task.save
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
    user = User.find(current_user.id)
    test = user.studentanswers.find_by_task_id(params[:id])
    @studentsanswer = test
    unless test.nil?
      @final = test.final
    end
  end

  def destroy
    group = Taskgroup.find_by_task_id(params[:id]).group_id
    Atask.find(params[:id]).destroy
    Taskgroup.find_by_task_id(params[:id]).destroy
    studentanswer = Studentanswer.where(task_id: params[:id])
    studentanswer.each do|s|
      unless s.answer.nil?
        s.answer.destroy
        s.answer.save
      end
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
