# encoding: utf-8
class Course < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :cls, :date, :idx, :field_id, :teacher_id, :title, :practice_record_attributes, :facility_applications_attributes, :course_review_attributes
  attr_readonly :field

  has_one :practice_record, :class_name => 'PracticeRecord', :foreign_key => 'course_id', :dependent => :destroy, :autosave => true
  has_one :course_review, :class_name => 'CourseReview', :foreign_key => 'course_id', :dependent => :destroy, :autosave => true
  has_many :facility_applications, :class_name => 'FacilityApplication', :foreign_key => 'course_id', :dependent => :destroy, :autosave => true
  belongs_to :field, :foreign_key => 'field_id'
  before_create :create_default_dependent
  before_save :before_save_check

  accepts_nested_attributes_for :practice_record, :course_review
  accepts_nested_attributes_for :facility_applications, :allow_destroy => true

  validates :cls, :date, :idx, :field_id, :title, :teacher_id, :presence => true
  validates :idx, :inclusion => 1..10
  validates_with FacilityApplicationsValidator

  def weekday
    return CommonController.get_weekday(date.wday)
  end

  def self.course_num_per_day
    return 10
  end

  def before_save_check
    if date < Date.today
      errors.add(:date, '不能选择今天以前的课程')
      return false
    end
    if self.self_conflict
      errors.add(:base, '该时段已有课程安排')
      return false
    end
  end

  def get_teacher_name
    return ApplicationHelper.get_teacher_name_by_id(teacher_id)
  end

  def create_default_dependent
    build_course_review
    build_practice_record
    return true
  end

  def self_conflict
    query = 'SELECT c.* from courses c ' +
        'WHERE date = "' + self.date.to_s + '" ' +
        'AND idx = ' + self.idx.to_s + ' ' +
        'AND teacher_id = ' + self.teacher_id.to_s + ' '
    if !self.id.nil?
      query += 'AND id <> ' + self.id.to_s
    end
    return Course.find_by_sql(query).any?
  end
end