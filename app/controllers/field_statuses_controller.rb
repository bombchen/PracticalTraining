# encoding: utf-8
class FieldStatusesController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /field_statuses
  # GET /field_statuses.json
  def index
    @field_statuses = FieldStatus.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /field_statuses/1
  # GET /field_statuses/1.json
  def show
    @field_status = FieldStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /field_statuses/new
  # GET /field_statuses/new.json
  def new
    @field_status = FieldStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /field_statuses/1/edit
  def edit
    @field_status = FieldStatus.find(params[:id])
    if @field_status.systematic
      render :js => %(show_warning('非法操作', '无法编辑系统属性'))
      return
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /field_statuses
  # POST /field_statuses.json
  def create
    @field_status = FieldStatus.new(params[:field_status])
    @field_status.systematic = false
    respond_to do |format|
      if @field_status.save
        format.html { redirect_to @field_status, notice: '创建场地状态成功' }
        format.js { redirect_to @field_status, :remote => true }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /field_statuses/1
  # PUT /field_statuses/1.json
  def update
    @field_status = FieldStatus.find(params[:id])
    if @field_status.systematic
      render :js => %(show_warning('非法操作', '无法编辑系统属性'))
      return
    end

    respond_to do |format|
      if @field_status.update_attributes(params[:field_status])
        format.html { redirect_to @field_status, notice: '更新场地状态成功' }
        format.js { redirect_to @field_status, :remote => true }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /field_statuses/1
  # DELETE /field_statuses/1.json
  def destroy
    @field_status = FieldStatus.find(params[:id])
    if @field_status.systematic
      render :js => %(show_warning('非法操作', '无法删除系统属性'))
      return
    end
    @field_status.destroy

    respond_to do |format|
      format.html { redirect_to field_statuses_url }
      format.js { redirect_to field_statuses_url, :remote => true }
    end
  end
end
