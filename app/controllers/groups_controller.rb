class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create

      @group = Group.new(group_params)
      user = User.find(@group.teacher_id)
    if @group.save
      user.group_id = @group.id
      user.save
      flash[:success] = "Group was created"
      redirect_to administration_path
    end

  end

  def edit

  end

  #def index
  #some code
  #end

  def show

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
