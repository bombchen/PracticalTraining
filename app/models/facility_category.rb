# encoding: utf-8
class FacilityCategory < ActiveRecord::Base
  attr_accessible :comments, :name
  attr_readonly :facilities

  has_many :facilities, :class_name => 'Facility', :foreign_key => 'category_id'

  def self.get_simple_selectors
    selectors = Array.new
    sel = SimpleSelector.new
    sel.id = -1
    sel.name = '全部'
    selectors.push(sel)
    FacilityCategory.all.each do |fc|
      sel = SimpleSelector.new
      sel.id = fc.id
      sel.name = fc.name
      selectors.push(sel)
    end
    selectors
  end
end
