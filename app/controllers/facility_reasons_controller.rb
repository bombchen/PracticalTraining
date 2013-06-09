# encoding: utf-8
class FacilityReasonsController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /facility_reasons
  # GET /facility_reasons.json
  def index
    @facility_reasons = FacilityReason.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facility_reasons }
    end
  end

  # GET /facility_reasons/1
  # GET /facility_reasons/1.json
  def show
    @facility_reason = FacilityReason.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facility_reason }
    end
  end

  # GET /facility_reasons/new
  # GET /facility_reasons/new.json
  def new
    @facility_reason = FacilityReason.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facility_reason }
    end
  end

  # GET /facility_reasons/1/edit
  def edit
    @facility_reason = FacilityReason.find(params[:id])
  end

  # POST /facility_reasons
  # POST /facility_reasons.json
  def create
    @facility_reason = FacilityReason.new(params[:facility_reason])
    @facility_reason.systematic = false

    respond_to do |format|
      if @facility_reason.save
        format.html { redirect_to @facility_reason, notice: '出入库原因已建立' }
        format.json { render json: @facility_reason, status: :created, location: @facility_reason }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facility_reasons/1
  # PUT /facility_reasons/1.json
  def update
    @facility_reason = FacilityReason.find(params[:id])
    if params[:if_add].any? && @facility_reason.if_add != params[:if_add]

    end

    respond_to do |format|
      if @facility_reason.update_attributes(params[:facility_reason])
        format.html { redirect_to @facility_reason, notice: '出入库原因已更新' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facility_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_reasons/1
  # DELETE /facility_reasons/1.json
  def destroy
    @facility_reason = FacilityReason.find(params[:id])
    @facility_reason.destroy

    respond_to do |format|
      format.html { redirect_to facility_reasons_url }
      format.json { head :no_content }
    end
  end
end
