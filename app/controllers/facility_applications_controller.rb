# encoding: utf-8
class FacilityApplicationsController < ApplicationController

  # GET /facility_applications
  # GET /facility_applications.json
  def index
    @facility_applications = FacilityApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facility_applications }
    end
  end

  # GET /facility_applications/1
  # GET /facility_applications/1.json
  def show
    @facility_application = FacilityApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facility_application }
    end
  end

  # GET /facility_applications/new
  # GET /facility_applications/new.json
  def new
    @facility_application = FacilityApplication.new
    @facility = Facility.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facility_application }
    end
  end

  # GET /facility_applications/1/edit
  def edit
    @facility_application = FacilityApplication.find(params[:id])
  end

  # POST /facility_applications
  # POST /facility_applications.json
  def create
    @facility_application = FacilityApplication.new(params[:facility_application])

    respond_to do |format|
      if @facility_application.save
        format.html { redirect_to @facility_application, notice: '材料申请已建立' }
        format.json { render json: @facility_application, status: :created, location: @facility_application }
      else
        format.html {
          flash[:error] =  @facility_application.errors.full_messages.to_sentence
          render action: 'new'
        }
        format.json { render json: @facility_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facility_applications/1
  # PUT /facility_applications/1.json
  def update
    @facility_application = FacilityApplication.find(params[:id])

    respond_to do |format|
      if @facility_application.update_attributes(params[:facility_application])
        format.html { redirect_to @facility_application, notice: '材料申请已更新' }
        format.json { head :no_content }
      else
        format.html {
          flash[:error] =  @facility_application.errors.full_messages.to_sentence
          render action: 'edit'
        }
        format.json { render json: @facility_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_applications/1
  # DELETE /facility_applications/1.json
  def destroy
    @facility_application = FacilityApplication.find(params[:id])
    @facility_application.destroy

    respond_to do |format|
      format.html { redirect_to facility_applications_url }
      format.json { head :no_content }
    end
  end
end
