# encoding: utf-8
class Role < ActiveRecord::Base
  attr_accessible :description, :friendly_name, :name
  attr_readonly :user_role_mappings

  validates :name, :presence => true, :uniqueness => true
  validates :friendly_name, :presence => true, :uniqueness => true

  has_many :user_role_mappings, :class_name => 'UserRoleMapping', :foreign_key => 'role_id'

  public
  def self.get_simple_selectors
    selectors = Array.new
    {
        'all' => '全部',
        'sysadmin' => '系统管理员',
        'schooladmin' => '学校领导',
        'storeadmin' => '实训管理员',
        'teacher' => '教师'
    }.each do |key, value|
      sel = SimpleSelector.new
      sel.id = key
      sel.name = value
      selectors.push sel
    end
    return selectors
  end
end
