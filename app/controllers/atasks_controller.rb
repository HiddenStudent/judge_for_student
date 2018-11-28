class AtasksController < ApplicationController
  def new
  end

  def edit
    @task = Atask.find(params[:id])
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

  end


  private

  def task_params
    params.require(:atask).permit(:content)
  end
end
