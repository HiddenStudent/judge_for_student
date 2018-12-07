class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "Group was created"
      redirect_to administration_path
    end
  end

  def edit

  end

  def show
    @group = Group.find_by(params[:id])
    taskgroup = TasksGroup.all
    tasks = Atask.all
    @tasks = []
    taskgroup.each do |taskgroup|
      tasks.each do |task|
        if taskgroup.atask_id == task.id
          next if task.nil?
          @tasks += [Atask.find(task.id)]
        end
      end
    end
  end

  def update

  end

  def destroy

  end

  private

  def group_params
    params.require(:group).permit(:teacher_id, :name)
  end
end
