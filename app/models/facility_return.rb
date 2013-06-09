# encoding: utf-8
class FacilityReturn < ActiveRecord::Base
  attr_accessible :application_id, :comments, :status, :borrowed_amount, :borrowed_time, :returned_amount, :returned_time
  attr_readonly :facility_application

  validates :status, :inclusion => 0..2

  belongs_to :facility_application, :foreign_key => 'application_id'

  def get_status
    return {
        0 => '未领用',
        1 => '已领用',
        2 => '已归还'
    }[filter_status]
  end

  def borrow_facility!
    if filter_status != 0
      return false
    end
    fa = facility_application.facility
    fat = FacilityTotal.find_by_facility_id(fa.id)
    FacilityReturn.transaction do
      fat.total -= borrowed_amount
      self.filter_status = 1
      fat.save!
      self.save!
      if fa.is_one_time?
        fio = FacilityIo.new
        fio.amount = borrowed_amount
        fio.date = Date.today
        fio.owner_id = facility_application.course.teacher_id
        fio.facility_id = fa.id
        fio.reason_id = FacilityReason.get_id_by_name('课程消耗')
        fio.save!
      end
    end
    return true
  end

  def return_facility!
    if filter_status != 1
      return false
    end
    fa = facility_application.facility
    fat = FacilityTotal.find_by_facility_id(fa.id)
    if (fa.is_one_time?)
      return false
    end
    FacilityReturn.transaction do
      fat.total += returned_amount
      self.filter_status = 2
      fat.save!
      self.save!
      if (returned_amount < borrowed_amount)
        fio = FacilityIo.new
        fio.amount = (borrowed_amount - returned_amount)
        fio.date = Date.today
        fio.owner_id = facility_application.course.teacher_id
        fio.facility_id = fa.id
        fio.reason_id = FacilityReason.get_id_by_name('课程损耗')
        fio.save!
      end
    end
    return true
  end

  def update_with_sync_up(attributes, options = {})
    if !attributes[:borrowed_amount].nil?
      self.borrowed_amount = attributes[:borrowed_amount]
      borrow_facility!
    else
      if !attributes[:returned_amount].nil?
        self.returned_amount = attributes[:returned_amount]
        return_facility!
      end
    end
  end

  def self.any_has_not_returned?
    return FacilityReturn.find_by_sql('SELECT fr.* FROM facility_returns fr INNER JOIN facility_applications fa on fr.application_id = fa.id INNER JOIN facilities f ON fa.facility_id = f.id WHERE fr.status <> 2 AND f.category <> 2').any?
  end
end
