# encoding: utf-8
require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :account, :hashed_password, :name, :salt, :user_role_mappings_attributes
  attr_accessible :password, :password_confirmation, :is_sys_admin, :is_school_admin, :is_store_admin, :is_teacher

  validates :account, :uniqueness => true, :presence => true, :format => {:with => /^[a-z][a-z0-9]*$/}
  validates :name, :presence => true
  validates :password, :confirmation => true
  before_create
  attr_accessor :password_confirmation
  attr_reader :password
  attr_accessor :is_sys_admin, :is_school_admin, :is_store_admin, :is_teacher

  has_many :user_role_mappings, :class_name => 'UserRoleMapping', :foreign_key => :user_id, :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :user_role_mappings, :allow_destroy => true


  validate :password_must_be_present

  def roles(roles)
    roles.reject(&:blank?)
  end

  def self.filter(acct, usn, rl)
    if rl == 'unknown'
      query = 'SELECT DISTINCT u.* FROM users u ' +
          'WHERE u.account LIKE "%' + acct + '%" ' +
          'AND u.name LIKE "%' + usn + '%" ' +
          'AND u.id NOT IN (' +
          'SELECT DISTINCT m.user_id ' +
          'FROM user_role_mappings m )'
    else
      query = 'SELECT DISTINCT u.* FROM users u ' +
          'LEFT JOIN user_role_mappings m ' +
          'ON u.id = m.user_id ' +
          'LEFT JOIN roles r ' +
          'ON m.role_id = r.id ' +
          'WHERE u.account LIKE "%' + acct + '%" ' +
          'AND u.name LIKE "%' + usn + '%" '
      if rl != 'all'
        query += 'AND r.name = "' + rl + '"'
      end
    end
    return find_by_sql(query)
  end

  def self.get_teacher_simple_selectors
    selectors = Array.new
    sel = SimpleSelector.new
    sel.id = -1
    sel.name = '全部'
    selectors.push(sel)
    User.all_teacher.each do |d|
      next if ()
      sel = SimpleSelector.new
      sel.id = d.id
      sel.name = d.name
      selectors.push(sel)
    end
    selectors
  end

  def self.all_teacher
    tid = Role.find_by_name('teacher').id
    teachers = (User.find_by_sql ['SELECT u.* FROM users u ' +
                                      'INNER JOIN user_role_mappings m ON u.id = m.user_id ' +
                                      'WHERE m.role_id = ?',
                                  tid])
    return teachers
  end

  def self.get_user_name_by_id(uid)
    return User.find(uid).name rescue '未知用户'
  end

  def self.get_login_user_name_by_id(uid)
    if (uid.nil?)
      return '未登录'
    end
    acct = User.find_by_id(uid)
    if (acct.nil?)
      return '未登录'
    end
    return acct.name
  end

  def self.verify_is_sys_admin_by_id(uid)
    if (uid.nil?)
      return false
    end
    return (User.find_by_sql ['SELECT * FROM users u '+
                                  'INNER JOIN user_role_mappings m ON u.id = m.user_id ' +
                                  'INNER JOIN roles r on m.role_id = r.id ' +
                                  'WHERE u.id = ? AND r.name = ?',
                              uid, 'sysadmin']).any?
  end

  def self.verify_is_school_admin_by_id(uid)
    if (uid.nil?)
      return false
    end
    return (User.find_by_sql ['SELECT * FROM users u '+
                                  'INNER JOIN user_role_mappings m ON u.id = m.user_id ' +
                                  'INNER JOIN roles r on m.role_id = r.id ' +
                                  'WHERE u.id = ? AND r.name = ?',
                              uid, 'schooladmin']).any?
  end

  def self.verify_is_store_admin_by_id(uid)
    if (uid.nil?)
      return false
    end
    return (User.find_by_sql ['SELECT * FROM users u '+
                                  'INNER JOIN user_role_mappings m ON u.id = m.user_id ' +
                                  'INNER JOIN roles r on m.role_id = r.id ' +
                                  'WHERE u.id = ? AND r.name = ?',
                              uid, 'storeadmin']).any?
  end

  def self.verify_is_teacher_by_id(uid)
    if (uid.nil?)
      return false
    end
    return (User.find_by_sql ['SELECT * FROM users u '+
                                  'INNER JOIN user_role_mappings m ON u.id = m.user_id ' +
                                  'INNER JOIN roles r on m.role_id = r.id ' +
                                  'WHERE u.id = ? AND r.name = ?',
                              uid, 'teacher']).any?
  end

  def self.authenticate(account, password)
    if user = User.find_by_account(account)
      if !user.nil? && user.hashed_password == encrypt_password(password, user.salt)
        return user
      end
    end
  end

  def self.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + 'wibble' + salt)
  end

  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def change_password

  end

  def validate_and_save!
    dup = Set.new
    cnt = Set.new
    if self.user_role_mappings.any?
      self.user_role_mappings.each do |m|
        if cnt.include?(m.role_id)
          dup.add(m.role.friendly_name) unless dup.include?(m.role.friendly_name)
        else
          cnt.add(m.role_id)
        end
      end
      if dup.any?
        dup.each do |d|
          errors.add(:base, '重复选择' + d)
        end
        return false
      end
    end
    self.save
  end

  def validate_and_update(attributes, options = {})
    if attributes[:user_role_mappings_attributes]
      dup = Set.new
      cnt = Set.new
      attributes[:user_role_mappings_attributes].each do |rm|
        m = rm[1]
        if cnt.include?(m[:role_id])
          dup.add(m[:role_id]) unless dup.include?(m[:role_id])
        else
          cnt.add(m[:role_id])
        end
      end
      if dup.any?
        dup.each do |d|
          errors.add(:base, '重复选择' + Role.find(d).friendly_name)
          return false
        end
      end
    end
    return self.update_attributes(attributes, options)
  end

  private
  def password_must_be_present
    errors.add(:password, '请输入密码') unless hashed_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
