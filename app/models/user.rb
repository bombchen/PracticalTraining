require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :account, :hashed_password, :name, :salt, :user_role_mappings_attributes
  attr_accessible :password, :password_confirmation

  validates :account, :uniqueness => true, :presence => true
  validates :name, :presence => true
  #validates :account, :format => {:with => /\A(^[a-z](([\._\-][a-z0-9])|[a-z0-9])*[a-z0-9]$)\Z/i}
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password

  has_many :user_role_mappings, :class_name => 'UserRoleMapping', :foreign_key => :user_id, :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :user_role_mappings, :allow_destroy => true


  validate :password_must_be_present

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
    acct = User.find(uid)
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

  private
  def password_must_be_present
    errors.add(:password, '请输入密码') unless hashed_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
