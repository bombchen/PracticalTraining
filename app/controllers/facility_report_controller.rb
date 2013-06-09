# encoding: utf-8
class FacilityReportController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  def index
    dt = params[:dt]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @facilities = Facility.all
    @records = FacilityIo.where('date >= ?', @begin_date).paginate(:page => params[:page])

    @reports = Hash.new
    @facilities.each do |f|
      @reports[f] = FacilityReport.new(f)
      @reports[f].total = f.facility_total.total
    end
    @records.each do |r|
      if r.facility_reason.if_add
        @reports[r.facility].in_stock += r.amount
      else
        @reports[r.facility].out_stock += r.amount
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end

  def generate_report
    dt = params[:dt]
    if dt > Date.today
      redirect_to '/facility_report', :alert => '开始日期不能晚于今天'
    end
    @begin_date = dt
    redirect_to '/facility_report'
  end
end
