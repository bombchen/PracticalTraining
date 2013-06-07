class FacilityIo < ActiveRecord::Base
  attr_accessible :amount, :date, :facility_id, :owner_id, :reason_id, :comments
  attr_readonly :facility, :facility_reason, :user

  validates :amount, :date, :facility_id, :reason_id, :presence => true
  validates :amount, :numericality => {:greater_than => 0}

  belongs_to :facility_reason, :foreign_key => 'reason_id'
  belongs_to :facility, :foreign_key => 'facility_id'
  belongs_to :user, :foreign_key => 'owner_id'

  def save_with_update_total
    if Stocking.any_not_finished?
      return
    end
    FacilityIo.transaction do
      cnt = amount * (facility_reason.if_add ? 1 : -1)
      fac = FacilityTotal.find_by_facility_id(facility_id)
      fac.total += cnt
      self.save!
      fac.save!
    end
  end

  def update_with_update_total(attributes, options = {})
    if Stocking.any_not_finished?
      return
    end
    FacilityIo.transaction do
      revert_amount = 0
      old = FacilityIo.find(id)
      if !old.nil?
        revert_amount = old.amount * (old.facility_reason.if_add ? 1 : -1)
      end
      if attributes[:amount].nil?
        new_amount = old.amount
      else
        new_amount = attributes[:amount].to_i
      end
      if attributes[:reason_id].nil?
        new_amount *= (old.facility_reason.if_add ? 1 : -1)
      else
        new_amount *= (FacilityReason.find(attributes[:reason_id].to_i).if_add ? 1 : -1)
      end
      fac = FacilityTotal.find_by_facility_id(facility_id)
      fac.total += (new_amount - revert_amount)
      self.update_attributes!(attributes, options)
      fac.save!
    end
  end

  def destroy_with_update_total
    if Stocking.any_not_finished?
      return
    end
    FacilityIo.transaction do
      revert_amount = amount * (facility_reason.if_add ? 1 : -1)
      fac = FacilityTotal.find_by_facility_id(facility_id)
      fac.total -= revert_amount
      fac.save!
      self.destroy
    end
  end
end