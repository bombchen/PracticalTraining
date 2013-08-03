# encoding: utf-8
class UserRoleMapping < ActiveRecord::Base
  attr_accessible :role_id, :user_id
  attr_readonly :user, :role

  belongs_to :user, :foreign_key => :user_id
  belongs_to :role, :foreign_key => :role_id
end
