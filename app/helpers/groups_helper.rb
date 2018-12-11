module GroupsHelper
  def current_teacher(group_id)
    unless current_user.nil?
      if  current_user.teacher? && Group.find(group_id).teacher_id == current_user.id
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
