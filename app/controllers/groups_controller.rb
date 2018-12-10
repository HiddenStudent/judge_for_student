class GroupsController < ApplicationController

  before_action :logged_in_user
  before_action :teacher, only: [:create,:update,:edit,:new,:destroy]
  before_action :activated

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      user = current_user
      user.group_id = @group.id
      user.save
      flash[:success] = "Group was created"
      redirect_to administration_path
    end
  end

  def edit

  end

  def show
    @group = Group.find_by(params[:id])
    taskgroups = Group.find(params[:id]).taskgroups
    @tasks = []
    taskgroups.each do |taskgroup|
      @tasks += [taskgroup.atask]
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
