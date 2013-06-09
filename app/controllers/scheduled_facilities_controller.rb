# encoding: utf-8
class ScheduledFacilitiesController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /scheduled_facilities
  # GET /scheduled_facilities.json
  def index
    @scheduled_facilities = ScheduledFacility.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scheduled_facilities }
    end
  end

  # GET /scheduled_facilities/1
  # GET /scheduled_facilities/1.json
  def show
    @scheduled_facility = ScheduledFacility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scheduled_facility }
    end
  end

  # GET /scheduled_facilities/new
  # GET /scheduled_facilities/new.json
  def new
    @scheduled_facility = ScheduledFacility.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scheduled_facility }
    end
  end

  # GET /scheduled_facilities/1/edit
  def edit
    @scheduled_facility = ScheduledFacility.find(params[:id])
  end

  # POST /scheduled_facilities
  # POST /scheduled_facilities.json
  def create
    @scheduled_facility = ScheduledFacility.new(params[:scheduled_facility])

    respond_to do |format|
      if @scheduled_facility.save
        format.html { redirect_to @scheduled_facility, notice: 'Scheduled facility was successfully created.' }
        format.json { render json: @scheduled_facility, status: :created, location: @scheduled_facility }
      else
        format.html { render action: "new" }
        format.json { render json: @scheduled_facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scheduled_facilities/1
  # PUT /scheduled_facilities/1.json
  def update
    @scheduled_facility = ScheduledFacility.find(params[:id])

    respond_to do |format|
      if @scheduled_facility.update_attributes(params[:scheduled_facility])
        format.html { redirect_to @scheduled_facility, notice: 'Scheduled facility was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scheduled_facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scheduled_facilities/1
  # DELETE /scheduled_facilities/1.json
  def destroy
    @scheduled_facility = ScheduledFacility.find(params[:id])
    @scheduled_facility.destroy

    respond_to do |format|
      format.html { redirect_to scheduled_facilities_url }
      format.json { head :no_content }
    end
  end
end
