# encoding: utf-8
class ScheduledFacility < ActiveRecord::Base
  attr_accessible :facility_id, :schedule_id
  attr_readonly :facility

  belongs_to :scheduled_course, :foreign_key => 'schedule_id'
  belongs_to :facility, :foreign_key => 'facility_id'
end
