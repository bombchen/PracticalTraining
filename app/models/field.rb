# encoding: utf-8
class Field < ActiveRecord::Base
  attr_accessible :description, :name, :status_id
  attr_readonly :field_status

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :courses, :class_name => 'Course', :foreign_key => 'field_id', :autosave => false
  belongs_to :field_status, :foreign_key => 'status_id'


  def self.get_available_fields(date, idx, cid)
    wday = Date.parse(date.to_s).wday
    cid = cid.nil? ? 0 : cid.to_i
    return Field.find_by_sql ['SELECT * FROM fields WHERE id IN ( ' +
                                  'SELECT f.id FROM fields f ' +
                                  'INNER JOIN field_statuses s ON f.status_id = s.id ' +
                                  'WHERE s.available = 1 ) ' +
                                  'AND id NOT IN ( '+
                                  'SELECT f.id FROM fields f ' +
                                  'INNER JOIN courses c ON f.id = c.field_id ' +
                                  'INNER JOIN course_reviews r ON c.id = r.course_id ' +
                                  'WHERE c.date = ? AND c.idx = ? AND r.status <> -1 AND c.id <> ? ) ' +
                                  'AND id NOT IN ( ' +
                                  'SELECT f.id FROM fields f ' +
                                  'INNER JOIN scheduled_courses sc ON f.id = sc.field_id ' +
                                  'WHERE sc.wday = ? AND sc.idx = ? AND sc.begin_date <= ? AND sc.end_date >= ? )',
                              date, idx, cid, wday, idx, date, date]
  end

  def self.get_available_fields_by_schedule(wday, idx, begin_date, end_date)
    return Field.find_by_sql ['SELECT * FROM fields WHERE id IN ( ' +
                                  'SELECT f.id FROM fields f ' +
                                  'INNER JOIN field_statuses s ON f.status_id = s.id ' +
                                  'WHERE s.available = 1 ) ' +
                                  'AND id NOT IN ( '+
                                  ' SELECT f.id FROM fields f ' +
                                  'LEFT JOIN scheduled_courses sc ON f.id = sc.field_id ' +
                                  'WHERE sc.wday = ? AND sc.idx = ? ' +
                                  'AND sc.begin_date <= ? AND sc.end_date >= ? )',
                              wday, idx, end_date, begin_date]

  end

end
