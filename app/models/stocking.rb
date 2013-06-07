class Stocking < ActiveRecord::Base
  attr_accessible :comments, :end_time, :finished, :owner_id, :start_time, :title, :stocking_details_attributes

  has_many :stocking_details, :class_name => 'StockingDetail', :foreign_key => 'stocking_id', :dependent => :delete_all, :autosave => true
  accepts_nested_attributes_for :stocking_details


  before_create :prepare_stocking

  def prepare_stocking
    if Stocking.any_not_finished? || FacilityReturn.any_has_not_returned?
      return false
    end
    self.start_time = Time.current
    self.finished = false
    Facility.all.each do |fac|
      self.stocking_details << StockingDetail.new(:facility_id => fac.id, :old_amount => fac.facility_total.total)
    end
  end

  def self.any_not_finished?
    return Stocking.find_by_sql('SELECT * FROM stockings WHERE finished <> 1').any?
  end

  def status_name
    return {
        true => '已完成',
        false => '未完成'
    }[finished]
  end

  def end_stocking!
    finished_sign = true
    self.stocking_details.each do |sd|
      if sd.new_amount.nil?
        finished_sign = false
      end
    end
    if !finished_sign
      return false
    end
    Stocking.transaction do
      self.stocking_details.each do |sd|
        sd.old_amount = sd.facility.facility_total.total
        if sd.new_amount != sd.old_amount
          fat = FacilityTotal.find_by_facility_id(sd.facility_id)
          fio = FacilityIo.new
          fio.date = Date.today
          fio.owner_id = self.owner_id
          fio.facility_id = sd.facility_id
          if sd.new_amount < sd.old_amount
            fio.amount = (sd.old_amount - sd.new_amount)
            fio.reason_id = FacilityReason.get_id_by_name('资产盘点缺失')
          else
            fio.amount = (sd.new_amount - sd.old_amount)
            fio.reason_id = FacilityReason.get_id_by_name('资产盘点盈余')
          end
          fat.total = sd.new_amount
          fat.save!
          fio.save!
        end
      end
      self.finished = true
      self.end_time = Time.now
      self.save!
    end
    return true
  end
end
