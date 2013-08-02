# encoding: utf-8
class FacilitiesController < ApplicationController
  append_before_filter :ensure_store_admin

  # GET /facilities
  # GET /facilities.json
  def index
    @filter_department = params[:dep].nil? ? -1 : params[:dep].to_i
    @filter_category = params[:cat].nil? ? -1 : params[:cat].to_i
    @filter_type = params[:typ].nil? ? -1 : params[:typ].to_i
    @filter_name = params[:search].nil? ? nil : params[:search].to_s.strip

    @facilities = Facility.filter(@filter_department, @filter_category, @filter_type, @filter_name).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
    @facility = Facility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /facilities/new
  # GET /facilities/new.json
  def new
    @facility = Facility.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /facilities/1/edit
  def edit
    @facility = Facility.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /facilities
  # POST /facilities.json
  def create
    @facility = Facility.new(params[:facility])
    @facility.name = @facility.name.strip
    respond_to do |format|
      if @facility.save
        format.html { redirect_to @facility, notice: '资产添加成功' }
        format.js { redirect_to @facility, :remote => true }
      else
        format.html {
          flash[:error] = @facility.errors.full_messages.to_sentence
          render action: 'new'
        }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /facilities/1
  # PUT /facilities/1.json
  def update
    @facility = Facility.find(params[:id])
    @facility.name = @facility.name.strip
    respond_to do |format|
      if @facility.update_attributes(params[:facility])
        format.html { redirect_to @facility, notice: '资产修改成功' }
        format.js { redirect_to @facility, :remote => true }
      else
        format.html {
          flash[:error] = @facility.errors.full_messages.to_sentence
          render action: 'edit'
        }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @facility = Facility.find(params[:id])

    respond_to do |format|
      if  @facility.destroy
        format.html { redirect_to facilities_url }
        format.js { redirect_to facilities_path, :remote => true }
      else
        format.html { redirect_to @facility, alert: '删除 '+@facility.name+' 失败' }
        format.js { render :js => %(show_warning('删除 #{@facility.name} 失败', '#{@facility.error_message}')) }
      end

    end
  end

end
