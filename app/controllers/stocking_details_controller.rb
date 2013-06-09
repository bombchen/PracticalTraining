# encoding: utf-8
class StockingDetailsController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  # GET /stocking_details
  # GET /stocking_details.json
  def index
    @stocking_details = StockingDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stocking_details }
    end
  end

  # GET /stocking_details/1
  # GET /stocking_details/1.json
  def show
    @stocking_detail = StockingDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stocking_detail }
    end
  end

  # GET /stocking_details/new
  # GET /stocking_details/new.json
  def new
    @stocking_detail = StockingDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stocking_detail }
    end
  end

  # GET /stocking_details/1/edit
  def edit
    @stocking_detail = StockingDetail.find(params[:id])
  end

  # POST /stocking_details
  # POST /stocking_details.json
  def create
    @stocking_detail = StockingDetail.new(params[:stocking_detail])

    respond_to do |format|
      if @stocking_detail.save
        format.html { redirect_to @stocking_detail, notice: 'Stocking detail was successfully created.' }
        format.json { render json: @stocking_detail, status: :created, location: @stocking_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @stocking_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stocking_details/1
  # PUT /stocking_details/1.json
  def update
    @stocking_detail = StockingDetail.find(params[:id])

    respond_to do |format|
      if @stocking_detail.update_attributes(params[:stocking_detail])
        format.html { redirect_to @stocking_detail, notice: 'Stocking detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stocking_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocking_details/1
  # DELETE /stocking_details/1.json
  def destroy
    @stocking_detail = StockingDetail.find(params[:id])
    @stocking_detail.destroy

    respond_to do |format|
      format.html { redirect_to stocking_details_url }
      format.json { head :no_content }
    end
  end
end
