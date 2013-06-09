# encoding: utf-8
class CommonController < ApplicationController

  public
  # @param [integer] idx
  # @return_process [string] weekday
  def self.get_weekday(idx)
    return {
        0 => '星期天',
        1 => '星期一',
        2 => '星期二',
        3 => '星期三',
        4 => '星期四',
        5 => '星期五',
        6 => '星期六',
    }[idx]
  end
end
