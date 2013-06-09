# encoding: utf-8
class FieldStatusesController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /field_statuses
  # GET /field_statuses.json
  def index
    @field_statuses = FieldStatus.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @field_statuses }
    end
  end

  # GET /field_statuses/1
  # GET /field_statuses/1.json
  def show
    @field_status = FieldStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @field_status }
    end
  end

  # GET /field_statuses/new
  # GET /field_statuses/new.json
  def new
    @field_status = FieldStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @field_status }
    end
  end

  # GET /field_statuses/1/edit
  def edit
    @field_status = FieldStatus.find(params[:id])
    if @field_status.systematic
      redirect_to field_status_path(@field_status), alert: '无法编辑系统属性'
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
        format.json { render json: @field_status, status: :created, location: @field_status }
      else
        format.html { render action: "new" }
        format.json { render json: @field_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /field_statuses/1
  # PUT /field_statuses/1.json
  def update
    @field_status = FieldStatus.find(params[:id])
    if @field_status.systematic
      render action: 'edit', alert: '无法编辑系统属性'
    end

    respond_to do |format|
      if @field_status.update_attributes(params[:field_status])
        format.html { redirect_to @field_status, notice: '更新场地状态成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @field_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /field_statuses/1
  # DELETE /field_statuses/1.json
  def destroy
    @field_status = FieldStatus.find(params[:id])
    if @field_status.systematic
      redirect_to field_status_path(@field_status), alert: '无法删除系统属性'
      return
    end
    @field_status.destroy

    respond_to do |format|
      format.html { redirect_to field_statuses_url }
      format.json { head :no_content }
    end
  end
end
