class FacilityProperty < ActiveRecord::Base
  attr_accessible :facility_id, :property_name, :property_value

  validates :property_name, :presence => true

  belongs_to :facility, :foreign_key => 'facility_id'
end
