class FacilityTraceController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  def index
    @facilities = Facility.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facilities }
    end
  end

  def show
    @facility = Facility.find(params[:id])

    dt = params[:dt]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    @traces = FacilityIo.where('facility_id = ? AND date >= ?', @facility.id, @begin_date).order('date DESC').paginate(:page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @traces }
    end
  end
end
