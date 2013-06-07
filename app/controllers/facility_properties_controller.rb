class FacilityPropertiesController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /facility_properties
  # GET /facility_properties.json
  def index
    @facility_properties = FacilityProperty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facility_properties }
    end
  end

  # GET /facility_properties/1
  # GET /facility_properties/1.json
  def show
    @facility_property = FacilityProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facility_property }
    end
  end

  # GET /facility_properties/new
  # GET /facility_properties/new.json
  def new
    @facility_property = FacilityProperty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facility_property }
    end
  end

  # GET /facility_properties/1/edit
  def edit
    @facility_property = FacilityProperty.find(params[:id])
  end

  # POST /facility_properties
  # POST /facility_properties.json
  def create
    @facility_property = FacilityProperty.new(params[:facility_property])

    respond_to do |format|
      if @facility_property.save
        format.html { redirect_to @facility_property, notice: 'Facility property was successfully created.' }
        format.json { render json: @facility_property, status: :created, location: @facility_property }
      else
        format.html { render action: "new" }
        format.json { render json: @facility_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facility_properties/1
  # PUT /facility_properties/1.json
  def update
    @facility_property = FacilityProperty.find(params[:id])

    respond_to do |format|
      if @facility_property.update_attributes(params[:facility_property])
        format.html { redirect_to @facility_property, notice: 'Facility property was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facility_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_properties/1
  # DELETE /facility_properties/1.json
  def destroy
    @facility_property = FacilityProperty.find(params[:id])
    @facility_property.destroy

    respond_to do |format|
      format.html { redirect_to facility_properties_url }
      format.json { head :no_content }
    end
  end
end
