# encoding: utf-8
class PracticeRecord < ActiveRecord::Base
  attr_accessible :course_id, :record, :record_review
  attr_readonly :course

  has_one :record_review, :class_name => 'RecordReview', :foreign_key => 'record_id', :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :record_review

  before_create :create_default_dependent

  belongs_to :course, :foreign_key => 'course_id'

  def create_default_dependent
    build_record_review
    return true
  end
end
