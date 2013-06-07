class FacilityReason < ActiveRecord::Base
  attr_accessible :if_add, :reason, :systematic

  validates :reason, :presence => true
  validates :reason, :uniqueness => true

  before_destroy :destroy_check

  def destroy_check
    if FacilityIo.find_all_by_reason_id(id).any?
      errors.add(:base, '出入库事由已被使用，无法删除')
      return false
    end
    return true
  end

  def in_or_out
    return {
        true => '入库',
        false => '出库'
    }[if_add]
  end

  def systematic_name
    return {
        true => '系统设置',
        false => '自定义'
    }[systematic]
  end

  def self.get_id_by_name(reason)
    return FacilityReason.find_by_reason(reason).id
  end
end
