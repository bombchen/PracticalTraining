# encoding: utf-8
class Role < ActiveRecord::Base
  attr_accessible :description, :friendly_name, :name
  attr_readonly :user_role_mappings

  validates :name, :presence => true, :uniqueness => true
  validates :friendly_name, :presence => true, :uniqueness => true

  has_many :user_role_mappings, :class_name => 'UserRoleMapping', :foreign_key => 'role_id'
end
