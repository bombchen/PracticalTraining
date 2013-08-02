# encoding: utf-8
class FacilityCategory < ActiveRecord::Base
  attr_accessible :comments, :name
  attr_readonly :facilities

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :facilities, :class_name => 'Facility', :foreign_key => 'category_id'

  before_destroy :destroy_check

  private
  def destroy_check
    if Facility.find_all_by_category_id(id).any?
      @error_message = '该类目已经在实训材料中使用，无法删除'
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
    FacilityCategory.all.each do |fc|
      sel = SimpleSelector.new
      sel.id = fc.id
      sel.name = fc.name
      selectors.push(sel)
    end
    selectors
  end
end
