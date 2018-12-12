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
      tasks_group = Taskgroup.new(task_id: task.id, group_id: params[:atask][:group_id])
      tasks_group.save
      task.taskgroup_id = tasks_group.id
      task.save
      flash[:success] = "Task was created"
      redirect_to group_url(params[:atask][:group_id])
    else
      redirect_to new_atask_url(params[:atask][:group_id])
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
      redirect_to group_url(Taskgroup.find_by_task_id(params[:id]).group_id)
    else
      redirect_to edit_atask_url(params[:id])
    end
  end

  def show
    @studentsanswer = Atask.first.studentanswers(params[:id],current_user.id)
  end

  def destroy
    group = Taskgroup.find_by_task_id(params[:id]).group_id
    Atask.find(params[:id]).destroy
    Taskgroup.find_by_task_id(params[:id]).destroy
    unless Studentanswer.first.nil?
      stanswers = Studentanswer.first.stanswers(params[:id])
      stanswers.each do |stans|
        Answer.find(stans.answer_id).destroy unless stans.answer_id.nil?
        Studentanswer.find(stans.id).destroy
      end
    end
    redirect_to group_path(group)
  end

  private

  def task_params
    params.require(:atask).permit(:name, :content)
  end
end
