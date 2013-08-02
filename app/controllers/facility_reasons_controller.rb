# encoding: utf-8
class FacilityReasonsController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /facility_reasons
  # GET /facility_reasons.json
  def index
    @facility_reasons = FacilityReason.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /facility_reasons/1
  # GET /facility_reasons/1.json
  def show
    @facility_reason = FacilityReason.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /facility_reasons/new
  # GET /facility_reasons/new.json
  def new
    @facility_reason = FacilityReason.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /facility_reasons/1/edit
  def edit
    @facility_reason = FacilityReason.find(params[:id])
    respond_to do |format|
      if @facility_reason.systematic
        format.html { redirect_to facility_reason_path(@facility_reason), alert: '无法编辑系统属性' }
        format.js { render :js => %(show_warning('非法操作', '无法编辑系统属性')) }
      else
        format.html
        format.js
      end
    end
  end

  # POST /facility_reasons
  # POST /facility_reasons.json
  def create
    @facility_reason = FacilityReason.new(params[:facility_reason])
    @facility_reason.systematic = false
    @facility_reason.reason = @facility_reason.reason.strip
    respond_to do |format|
      if @facility_reason.save
        format.html { redirect_to @facility_reason, notice: '出入库原因已建立' }
        format.js { redirect_to @facility_reason, :remote => true }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /facility_reasons/1
  # PUT /facility_reasons/1.json
  def update
    @facility_reason = FacilityReason.find(params[:id])
    @facility_reason.reason = @facility_reason.reason.strip
    respond_to do |format|
      if !params[:if_add].nil? && @facility_reason.if_add != params[:if_add]
        format.html { render action: 'edit', alert: '无法更改出/入库' }
        format.js { render :js => %(show_warning('非法操作', '无法更改出/入库')) }
      elsif @facility_reason.systematic
        format.html { render action: 'edit', alert: '无法编辑系统属性' }
        format.js { render :js => %(show_warning('非法操作', '无法编辑系统属性')) }
      elsif @facility_reason.update_attributes(params[:facility_reason])
        format.html { redirect_to @facility_reason, notice: '出入库原因已更新' }
        format.js { redirect_to @facility_reason, :remote => true }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /facility_reasons/1
  # DELETE /facility_reasons/1.json
  def destroy
    @facility_reason = FacilityReason.find(params[:id])

    respond_to do |format|
      if @facility_reason.systematic
        format.html { redirect_to @facility_reason, alert: '无法删除系统属性' }
        format.js { render :js => %(show_warning('非法操作', '无法删除系统属性')) }
      elsif @facility_reason.destroy
        format.html { redirect_to facility_reasons_url }
        format.js { redirect_to facility_reasons_url, :remote => true }
      else
        format.html { redirect_to @facility_reason, alert: '删除 '+@facility_reason.name+' 失败' }
        format.js { render :js => %(show_warning('删除 #{@facility_reason.name} 失败', '#{@facility_reason.error_message}')) }
      end
    end
  end
end
