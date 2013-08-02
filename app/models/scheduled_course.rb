# encoding: utf-8
require 'time'
class ScheduledCourse < ActiveRecord::Base
  attr_accessible :begin_date, :cls, :end_date, :idx, :field_id, :teacher_id, :title, :wday, :scheduled_facilities, :scheduled_facilities_attributes
  attr_readonly :field

  validates :cls, :idx, :field_id, :teacher_id, :title, :wday, :presence => true

  belongs_to :field, :foreign_key => 'field_id'
  has_many :scheduled_facilities, :class_name => 'ScheduledFacility', :foreign_key => 'schedule_id', :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :scheduled_facilities, :allow_destroy => true

  validate :end_date_must_later_than_begin_date
  validate :scheduled_facilities_are_validate

  protected
  def end_date_must_later_than_begin_date
    bv = (Date.parse(begin_date.to_s) rescue ArgumentError) == ArgumentError
    ev = (Date.parse(end_date.to_s) rescue ArgumentError) == ArgumentError
    if bv or ev
      if bv
        errors.add(:begin_date, '不是有效日期')
      end
      if ev
        errors.add(:end_date, '不是有效日期')
      end
    else
      errors.add(:end_date, '结束日期不能早于开始日期') unless self.begin_date <= self.end_date rescue false
    end
  end

  def scheduled_facilities_are_validate
    if self.scheduled_facilities.any?
      self.scheduled_facilities.each do |fac|
        if fac.facility_id.nil? or fac.facility_id == ''
          errors.add(:base, '请选择实训材料')
        end
      end
    end
  end

  public
  def weekday
    return CommonController.get_weekday(wday)
  end
end
