# encoding: utf-8
class RecordReview < ActiveRecord::Base
  attr_accessible :comments, :record_id, :status
  attr_readonly :practice_record

  validates :status, :inclusion => -1..2

  belongs_to :practice_record, :foreign_key => 'record_id'

  def get_status
    return {
        1 => '已编写',
        2 => '审核通过',
        -1 => '审核失败',
        0 => '未编写'
    }[status] rescue '未知状态'
  end
end
