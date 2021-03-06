# encoding: utf-8
class FacilityAlertController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  def index
    @candidates = Facility.find_by_sql('SELECT f.* FROM facilities f INNER JOIN facility_totals ft on f.ID = ft.facility_id WHERE ft.total < f.alert_amount').paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def application
    @candidates = Facility.find_by_sql('SELECT f.* FROM facilities f INNER JOIN facility_totals ft on f.ID = ft.facility_id WHERE ft.total < f.alert_amount').paginate(:page => params[:page])
    respond_to do |format|
      format.xls
    end
  end
end
