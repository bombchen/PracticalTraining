# encoding: utf-8
class FacilityApplication < ActiveRecord::Base
  attr_accessible :applied, :course_id, :facility_id, :facility_return, :facility_return_attributes
  attr_readonly :facility, :course

  validates :applied, :numericality => {:greater_than => 0}

  has_one :facility_return, :class_name => 'FacilityReturn', :foreign_key => 'application_id', :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :facility_return
  before_create :create_default_dependent

  belongs_to :course, :foreign_key => 'course_id'
  belongs_to :facility, :foreign_key => 'facility_id'

  def facility_name
    return facility.name
  end

  def facility_unit
    return facility.unit
  end

  def facility_name_with_unit
    return facility.name + ' (' + facility.unit + ')'
  end

  def create_default_dependent
    build_facility_return
    return true
  end
end
