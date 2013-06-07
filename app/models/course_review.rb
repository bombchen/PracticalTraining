class CourseReview < ActiveRecord::Base
  attr_accessible :comments, :course_id, :status
  attr_readonly :course

  validates :status, :inclusion => -1..1

  belongs_to :course, :foreign_key => 'course_id'

  def get_status
    return {
        0 => '未审核',
        1 => '审核通过',
        -1 => '审核失败'
    }[status] rescue '未知状态'
  end

  def self.get_status_code(condition)
    return {
        '未审核' => 0,
        '审核通过' => 1,
        '审核失败' => -1
    }[condition]
  end

  def self.filter(begin_date, end_date, condition)
    query = "SELECT cr.* FROM courses c INNER JOIN course_reviews cr ON c.id = cr.course_id WHERE c.date BETWEEN '%s' AND '%s'" %[begin_date, end_date]
    if condition != '全部'
      query = query + ' AND cr.status = %s' %[CourseReview.get_status_code(condition)]
    end
    return find_by_sql(query)
  end
end
