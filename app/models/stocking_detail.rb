class StockingDetail < ActiveRecord::Base
  attr_accessible :facility_id, :new_amount, :old_amount, :stocking_id
  attr_readonly :facility, :stocking

  belongs_to :stocking, :foreign_key => 'stocking_id'
  belongs_to :facility, :foreign_key => 'facility_id'
end
