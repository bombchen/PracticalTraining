# encoding: utf-8
class Department < ActiveRecord::Base
  attr_accessible :description, :name
  attr_readonly :facilities

  has_many :facilities, :foreign_key => 'department_id'

  def self.get_simple_selectors
    selectors = Array.new
    sel = SimpleSelector.new
    sel.id = -1
    sel.name = '全部'
    selectors.push(sel)
    Department.all.each do |d|
      sel = SimpleSelector.new
      sel.id = d.id
      sel.name = d.name
      selectors.push(sel)
    end
    selectors
  end
end
