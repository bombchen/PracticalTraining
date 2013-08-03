# encoding: utf-8
class StockingDetail < ActiveRecord::Base
  attr_accessible :facility_id, :new_amount, :old_amount, :stocking_id
  attr_readonly :facility, :stocking
  validates :new_amount, :numericality => {:greater_than_or_equal_to => 0}

  belongs_to :stocking, :foreign_key => 'stocking_id'
  belongs_to :facility, :foreign_key => 'facility_id'
end
