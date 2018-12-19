class TasksController < ApplicationController

  before_action :logged_in_user
  before_action :teacher, except: [:show]
  before_action :activated

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    if task.save
      tasks_group = TaskGroup.new(task_id: task.id, group_id: params[:task][:group_id])
      tasks_group.save
      flash[:success] = 'Task was created'
      redirect_to group_url(params[:task][:group_id])
    else
      redirect_to new_task_url(params[:task][:group_id])
    end
  end

  def edit
    @task = Task.find(params[:id])
    @users = User.all
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = 'Task updated'
      redirect_to group_url(TaskGroup.find_by_task_id(params[:id]).group_id)
    else
      redirect_to edit_task_url(params[:id])
    end
  end

  def show
    @task = Task.find(params[:id])
    @student_answer = Answer.where(task_id: params[:id], user_id: current_user.id).last
  end

  def destroy
    group = TaskGroup.find_by_task_id(params[:id]).group_id
    Task.find(params[:id]).destroy
    redirect_to group_path(group)
  end

  private

  def task_params
    params.require(:task).permit(:name, :content)
  end
end
