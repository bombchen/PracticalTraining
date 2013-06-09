# encoding: utf-8
class ReportUnitIO
  attr_accessor :facility, :in_amount, :out_amount, :remaining

  def initialize(facility)
    @facility = facility
    @in_amount = 0
    @out_amount = 0
    @remaining = 0
  end

end