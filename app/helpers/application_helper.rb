module ApplicationHelper
  def self.get_teacher_name_by_id(id)
    return User.get_user_name_by_id(id)
  end
  def self.get_style_class_name_by_course_status(id)
    ret = {
        0 => 'schedule-pending-review',
        1 => 'schedule-approved',
        -1 => 'schedule-rejected'
    }[id]
    return ret
  end
end
