# encoding: utf-8
class FacilityTraceController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  def index
    @facilities = Facility.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    @facility = Facility.find(params[:id])

    dt = params[:dt]
    @begin_date = (dt.nil? ? 1.month.ago.to_date : dt)
    query = 'SELECT fio.* FROM facility_ios fio ' +
        'WHERE fio.facility_id = ' + @facility.id.to_s + ' ' +
        'AND fio.date >= "' + @begin_date.to_s + '" ' +
        'ORDER BY fio.date DESC'
    @traces = FacilityIo.find_by_sql(query).paginate(:page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end
end
