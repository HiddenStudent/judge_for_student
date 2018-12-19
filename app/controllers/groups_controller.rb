class GroupsController < ApplicationController

  before_action :logged_in_user
  before_action :teacher, except: [:index, :show]
  before_action :activated
  before_action :teacher, except: [:index, :show]

  def edit
    @group = Group.find_by_teacher_id(current_user.id)
    @users = User.all
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_update_params)
      flash[:success] = 'Group updated'
      redirect_to administration_path
    else
      redirect_to edit_group_url(params[:id])
    end
  end

  def index
    @groups = current_user.groups(current_user.id)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_create_params)
    if @group.save
      group_user = GroupUser.new(group_id: @group.id, user_id: current_user.id)
      group_user.save
      flash[:success] = 'Group was created'
      redirect_to administration_path
    else
      render 'new'
    end
  end

  def show
    @tasks = Group.first.show_tasks(params[:id])
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:danger] = 'group was deleted'
    redirect_to administration_path
  end

  private

  def group_create_params
    params.require(:group).permit(:teacher_id, :name)
  end

  private

  def group_update_params
    params.require(:group).permit(:name)
  end
end
