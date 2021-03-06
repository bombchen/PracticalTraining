# encoding: utf-8
class FacilityReturn < ActiveRecord::Base
  attr_accessible :application_id, :comments, :status, :borrowed_amount, :borrowed_time, :returned_amount, :returned_time
  attr_readonly :facility_application

  validates :status, :inclusion => 0..2
  validates :borrowed_amount, :numericality => {:greater_than => 0}

  belongs_to :facility_application, :foreign_key => 'application_id'

  public
  def error_message
    @error_message ||= ''
  end

  def get_status
    return {
        0 => '未领用',
        1 => '已领用',
        2 => '已归还'
    }[status]
  end

  def borrow_facility!
    if status != 0
      @error_message = '该状态无法领用'
      return false
    end
    fa = facility_application.facility
    fat = FacilityTotal.find_by_facility_id(fa.id)
    if (borrowed_amount < 0)
      errors.add(:borrowed_amount, '不能为负数')
      return false
    end
    if borrowed_amount > fa.facility_total.total
      errors.add(:borrowed_amount, '超过最大可领用数')
      return false
    end
    FacilityReturn.transaction do
      fat.total -= borrowed_amount
      self.status = 1
      self.borrowed_time = DateTime.now
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
    end rescue return false
    return true
  end

  def return_facility!
    if status != 1
      @error_message = '该状态无法归还'
      return false
    end
    fa = facility_application.facility
    fat = FacilityTotal.find_by_facility_id(fa.id)
    if (fa.is_one_time?)
      @error_message = '一次性材料无需归还'
      return false
    end
    FacilityReturn.transaction do
      fat.total += returned_amount
      self.status = 2
      self.returned_time = DateTime.now
      fat.save!
      self.save!
      if (returned_amount < 0)
        errors.add(:returned_amount, '不能为负数')
        raise FacilityReturn::Rollback
      end
      if (returned_amount > borrowed_amount)
        errors.add(:returned_amount, '不能多于领用数量')
        raise FacilityReturn::Rollback
      end
      if (returned_amount < borrowed_amount)
        fio = FacilityIo.new
        fio.amount = (borrowed_amount - returned_amount)
        fio.date = Date.today
        fio.owner_id = facility_application.course.teacher_id
        fio.facility_id = fa.id
        fio.reason_id = FacilityReason.get_id_by_name('课程损耗')
        fio.save!
      end
    end rescue return false
    return true
  end

  def update_with_sync_up(attributes, options = {})
    res = false
    if !attributes[:borrowed_amount].nil?
      self.borrowed_amount = attributes[:borrowed_amount]
      res = borrow_facility!
    else
      if !attributes[:returned_amount].nil?
        self.returned_amount = attributes[:returned_amount]
        res = return_facility!
      end
    end
    return res
  end

  def self.any_has_not_returned?
    return (FacilityReturn.find_by_sql ['SELECT fr.* FROM facility_returns fr ' +
                                            'JOIN facility_applications fa on fr.application_id = fa.id ' +
                                            'JOIN facilities f ON fa.facility_id = f.id '+
                                            'WHERE fr.status = 1 '+
                                            'AND f.facility_type <> 2']).any?
  end
end
