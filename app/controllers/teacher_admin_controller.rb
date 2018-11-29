class TeacherAdminController < ApplicationController
  def index

  end

  def new
  @users = User.all
  end

  def create_task
    @task = Atask.new(content:params[:teach][:content], id_lang:params[:teach][:id_lang])
    if @task.save
      flash[:success] = "Task was created"
      redirect_to administration_path
      #debugger
      else

      flash.now[:danger] = 'Invalid combination'
      render 'new'
    end
  end

  def tasks
  @tasks = Atask.all
  end

  def edit

    #params.require(:id)
    @task = Atask.find(params[:id])

  end

  def tasks_progress

  end


 end