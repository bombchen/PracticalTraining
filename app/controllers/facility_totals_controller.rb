# encoding: utf-8
class FacilityTotalsController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  # GET /facility_totals
  # GET /facility_totals.json
  def index
    @facility_totals = FacilityTotal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facility_totals }
    end
  end

  # GET /facility_totals/1
  # GET /facility_totals/1.json
  def show
    @facility_total = FacilityTotal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facility_total }
    end
  end

  # GET /facility_totals/new
  # GET /facility_totals/new.json
  def new
    @facility_total = FacilityTotal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facility_total }
    end
  end

  # GET /facility_totals/1/edit
  def edit
    @facility_total = FacilityTotal.find(params[:id])
  end

  # POST /facility_totals
  # POST /facility_totals.json
  def create
    @facility_total = FacilityTotal.new(params[:facility_total])

    respond_to do |format|
      if @facility_total.save
        format.html { redirect_to @facility_total, notice: 'Facility total was successfully created.' }
        format.json { render json: @facility_total, status: :created, location: @facility_total }
      else
        format.html { render action: "new" }
        format.json { render json: @facility_total.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facility_totals/1
  # PUT /facility_totals/1.json
  def update
    @facility_total = FacilityTotal.find(params[:id])

    respond_to do |format|
      if @facility_total.update_attributes(params[:facility_total])
        format.html { redirect_to @facility_total, notice: 'Facility total was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facility_total.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_totals/1
  # DELETE /facility_totals/1.json
  def destroy
    @facility_total = FacilityTotal.find(params[:id])
    @facility_total.destroy

    respond_to do |format|
      format.html { redirect_to facility_totals_url }
      format.json { head :no_content }
    end
  end
end
