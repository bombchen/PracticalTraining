# encoding: utf-8
class FacilityCategoriesController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /facility_categories
  # GET /facility_categories.json
  def index
    @facility_categories = FacilityCategory.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facility_categories }
    end
  end

  # GET /facility_categories/1
  # GET /facility_categories/1.json
  def show
    @facility_category = FacilityCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facility_category }
    end
  end

  # GET /facility_categories/new
  # GET /facility_categories/new.json
  def new
    @facility_category = FacilityCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facility_category }
    end
  end

  # GET /facility_categories/1/edit
  def edit
    @facility_category = FacilityCategory.find(params[:id])
  end

  # POST /facility_categories
  # POST /facility_categories.json
  def create
    @facility_category = FacilityCategory.new(params[:facility_category])

    respond_to do |format|
      if @facility_category.save
        format.html { redirect_to @facility_category, notice: '新资产类目已创建' }
        format.json { render json: @facility_category, status: :created, location: @facility_category }
      else
        format.html { render action: "new" }
        format.json { render json: @facility_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facility_categories/1
  # PUT /facility_categories/1.json
  def update
    @facility_category = FacilityCategory.find(params[:id])

    respond_to do |format|
      if @facility_category.update_attributes(params[:facility_category])
        format.html { redirect_to @facility_category, notice: '资产类目已更新' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facility_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_categories/1
  # DELETE /facility_categories/1.json
  def destroy
    @facility_category = FacilityCategory.find(params[:id])
    @facility_category.destroy

    respond_to do |format|
      format.html { redirect_to facility_categories_url }
      format.json { head :no_content }
    end
  end
end
