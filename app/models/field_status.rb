# encoding: utf-8
class FieldStatus < ActiveRecord::Base
  attr_accessible :available, :name, :systematic
  validates :name, :presence => true
  validates :name, :uniqueness => true

  before_destroy :destroy_check

  protected
  def destroy_check
    if Field.find_all_by_status_id(id).any?
      @error_message = '场地状态已被使用，无法删除'
      return false
    end
    return true
  end

  public
  def error_message
    @error_message ||= ''
  end

  def availability_name
    return {
        true => '可用',
        false => '不可用'
    }[available]
  end
  def systematic_name
    return {
        true => '系统设置',
        false => '自定义'
    }[systematic]
  end
end
