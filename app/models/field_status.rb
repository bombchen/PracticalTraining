# encoding: utf-8
class FieldStatus < ActiveRecord::Base
  attr_accessible :available, :name, :systematic
  validates :name, :presence => true
  validates :name, :uniqueness => true

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
