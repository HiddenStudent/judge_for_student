class AtasksController < ApplicationController

  def new
    @task = Atask.new
  end

  def create
    @task = Atask.new(task_params)
    if @task.save
      @tasks_group = TasksGroup.new do |u|
        u.atask_id = @task.id
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
  end


  private

  def task_params
    params.require(:atask).permit(:name, :content)
  end
end
