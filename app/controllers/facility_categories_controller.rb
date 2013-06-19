# encoding: utf-8
class FacilityCategoriesController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /facility_categories
  # GET /facility_categories.json
  def index
    @facility_categories = FacilityCategory.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /facility_categories/1
  # GET /facility_categories/1.json
  def show
    @facility_category = FacilityCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /facility_categories/new
  # GET /facility_categories/new.json
  def new
    @facility_category = FacilityCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /facility_categories/1/edit
  def edit
    @facility_category = FacilityCategory.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /facility_categories
  # POST /facility_categories.json
  def create
    @facility_category = FacilityCategory.new(params[:facility_category])

    respond_to do |format|
      if @facility_category.save
        format.html { redirect_to @facility_category, notice: '新资产类目已创建' }
        format.js { redirect @facility_category, :remote => true }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
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
        format.js { redirect_to @facility_category, :remote => true }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /facility_categories/1
  # DELETE /facility_categories/1.json
  def destroy
    @facility_category = FacilityCategory.find(params[:id])
    respond_to do |format|
      if  @facility_category.destroy
        format.html { redirect_to facility_categories_path }
        format.js { redirect_to facility_categories_path, :remote => true }
      else
        format.html { redirect_to @facility_category, alert: '删除 '+@facility_category.name+' 失败' }
        format.js { render :js => %(show_warning('删除 #{@facility_category.name} 失败', '#{@facility_category.error_message}')) }
      end
    end
  end
end
