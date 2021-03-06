# encoding: utf-8
class Department < ActiveRecord::Base
  attr_accessible :description, :name
  attr_readonly :facilities

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :facilities, :foreign_key => 'department_id'

  before_destroy :destroy_check

  private
  def destroy_check
    if Facility.find_all_by_department_id(id).any?
      @error_message = '该部门已经在实训材料中使用，无法删除'
      return false
    end
    return true
  end

  public
  def error_message
    @error_message ||= ''
  end

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
