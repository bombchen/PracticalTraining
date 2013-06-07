class ScheduledCourse < ActiveRecord::Base
  attr_accessible :begin_date, :cls, :end_date, :idx, :field_id, :teacher_id, :title, :wday, :scheduled_facilities, :scheduled_facilities_attributes
  attr_readonly :field

  validates :begin_date, :end_date, :cls, :idx, :field_id, :teacher_id, :title, :wday, :presence => true

  belongs_to :field, :foreign_key => 'field_id'
  has_many :scheduled_facilities, :class_name => 'ScheduledFacility', :foreign_key => 'schedule_id', :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :scheduled_facilities, :allow_destroy => true

  public
  def weekday
    return CommonController.get_weekday(wday)
  end
end
