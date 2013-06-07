class FacilityTotal < ActiveRecord::Base
  attr_accessible :facility_id, :total
  attr_readonly :facility

  validates :total, :numericality => {:greater_than_or_equal_to => 0}

  belongs_to :facility, :foreign_key => 'facility_id'
end
