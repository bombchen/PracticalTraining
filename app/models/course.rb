class Course < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :cls, :date, :idx, :field_id, :teacher_id, :title, :practice_record_attributes, :facility_applications_attributes, :course_review_attributes
  attr_readonly :field

  has_one :practice_record, :class_name => 'PracticeRecord', :foreign_key => 'course_id', :dependent => :destroy, :autosave => true
  has_one :course_review, :class_name => 'CourseReview', :foreign_key => 'course_id', :dependent => :destroy, :autosave => true
  has_many :facility_applications, :class_name => 'FacilityApplication', :foreign_key => 'course_id', :dependent => :destroy, :autosave => true
  belongs_to :field, :foreign_key => 'field_id'
  before_create :create_default_dependent

  accepts_nested_attributes_for :practice_record, :course_review
  accepts_nested_attributes_for :facility_applications, :allow_destroy => true

  validates :cls, :date, :idx, :field_id, :title, :teacher_id, :presence => true
  validates :idx, :inclusion => 1..10
  #validate :date_cannot_be_in_the_past
  validates_with FacilityApplicationsValidator

  def weekday
    return CommonController.get_weekday(date.wday)
  end

  def self.course_num_per_day
    return 10
  end

  def date_cannot_be_in_the_past
    if !date.blank? and date < Date.today
      errors.add(:date, '不能选择今天以前的课程')
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
end