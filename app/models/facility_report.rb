class FacilityReport
  attr_accessor :facility, :in_stock, :out_stock, :total

  def initialize(facility)
    @facility = facility
    @in_stock = 0
    @out_stock = 0
    @total = 0
  end
end