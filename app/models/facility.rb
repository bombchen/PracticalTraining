# encoding: utf-8
class Facility < ActiveRecord::Base
  attr_accessible :asset_id, :facility_type, :comments, :description, :name, :unit, :alert_amount, :category_id, :department_id, :unit_price, :facility_properties_attributes, :facility_total
  attr_readonly :facility_category, :department

  validates :asset_id, :facility_type, :name, :unit, :alert_amount, :presence => true
  validates :name, :asset_id, :uniqueness => true
  validates :facility_type, :inclusion => 0..2

  has_many :facility_applications, :class_name => 'FacilityApplication', :foreign_key => 'facility_id', :autosave => true
  has_many :facility_properties, :class_name => 'FacilityProperty', :foreign_key => 'facility_id', :dependent => :destroy, :autosave => true
  has_many :scheduled_facilities, :class_name => 'ScheduledFacility', :foreign_key => 'facility_id', :autosave => true
  has_many :stocking_details, :class_name => 'StockingDetail', :foreign_key => 'facility_id'
  has_one :facility_total, :class_name => 'FacilityTotal', :foreign_key => 'facility_id', :dependent => :destroy, :autosave => true
  belongs_to :facility_category, :foreign_key => 'category_id'
  belongs_to :department, :foreign_key => 'department_id'
  accepts_nested_attributes_for :facility_applications, :allow_destroy => true
  accepts_nested_attributes_for :facility_properties, :allow_destroy => true
  accepts_nested_attributes_for :facility_total

  before_create :create_default_dependent

  before_destroy :destroy_check


  private
  def destroy_check
    if FacilityApplication.find_all_by_facility_id(id).any? || ScheduledFacility.find_all_by_facility_id(id).any?
      @error_message = '材料已被申请，无法删除'
      return false
    end
    if facility_total.total != 0
      @error_message = '还有剩余材料，无法删除'
      return false
    end
    if FacilityIo.find_all_by_facility_id(id).any?
      @error_message = '已有出入库记录，无法删除'
      return false
    end
    if StockingDetail.find_all_by_facility_id(id).any?
      @error_message = '已有资产盘点记录，无法删除'
      return false
    end
    return true
  end

  public
  def error_message
    @error_message ||= ''
  end

  def name_with_unit
    return name + ' (' + unit + ')'
  end

  def is_one_time?
    return facility_type == 2
  end

  def if_one_time_name
    return {
        true => '是',
        false => '否'
    }[is_one_time?]
  end

  def need_alert?
    return facility_total.total < alert
  end

  def create_default_dependent
    build_facility_total
    return true
  end

  def facility_type_name
    return {
        0 => '大型设备',
        1 => '普通设备',
        2 => '消耗材料'
    }[facility_type]
  end

  def self.facility_type_id(typ)
    return {
        '大型设备' => 0,
        '普通设备' => 1,
        '消耗材料' => 2
    }[typ]
  end

  def self.search(search)
    if search.nil?
      find(:all)
    else
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    end
  end

  def self.filter(dep, cat, typ, name)
    query = 'SELECT f.* FROM facilities f ' +
        'WHERE f.id IS NOT NULL'
    if dep != -1
      query = query + ' AND f.department_id = ' + dep.to_s
    end
    if cat != -1
      query = query + ' AND f.category_id = ' + cat.to_s
    end
    if typ != -1
      query = query + ' AND f.facility_type = ' + typ.to_s
    end
    if !name.nil?
      query = query + ' AND f.name LIKE "%' + name +'%"'
    end
    return find_by_sql(query)
  end

  def self.get_simple_selectors
    selectors = Array.new
    {
        -1 => '全部',
        0 => '大型设备',
        1 => '普通设备',
        2 => '消耗材料'
    }.each do |key, value|
      sel = SimpleSelector.new
      sel.id = key
      sel.name = value
      selectors.push sel
    end
    return selectors
  end
end
