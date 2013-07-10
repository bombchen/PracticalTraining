# encoding: utf-8
class FacilityIosController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /facility_ios
  # GET /facility_ios.json
  def index
    @facility_ios = FacilityIo.all(:order => 'date desc, id desc').paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /facility_ios/1
  # GET /facility_ios/1.json
  def show
    @facility_io = FacilityIo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /facility_ios/new
  # GET /facility_ios/new.json
  def new
    @facility_io = FacilityIo.new

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to facility_ios_path, alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        format.html # new.html.erb
        format.js
      end
    end
  end

  # GET /facility_ios/1/edit
  def edit
    @facility_io = FacilityIo.find(params[:id])
    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to facility_ios_path, alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        format.html
        format.js
      end
    end
  end

  # POST /facility_ios
  # POST /facility_ios.json
  def create
    @facility_io = FacilityIo.new(params[:facility_io])
    @facility_io.owner_id = session[:user_id]
    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to '/facility_ios', alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        if @facility_io.save_with_update_total
          format.html { redirect_to @facility_io, notice: '出入库记录已建立' }
          format.js { redirect_to @facility_io, :remote => true }
        else
          format.html { render action: 'new' }
          format.js { render action: 'new' }
        end
      end
    end
  end

  # PUT /facility_ios/1
  # PUT /facility_ios/1.json
  def update
    @facility_io = FacilityIo.find(params[:id])

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to '/facility_ios', alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        if @facility_io.update_with_update_total(params[:facility_io])
          format.html { redirect_to @facility_io, notice: '出入库记录已更新' }
          format.js { redirect_to @facility_io, :remote => true }
        else
          format.html { render action: 'edit' }
          format.js { render action: 'edit' }
        end
      end
    end
  end

  # DELETE /facility_ios/1
  # DELETE /facility_ios/1.json
  def destroy
    @facility_io = FacilityIo.find(params[:id])
    @facility_io.destroy_with_update_total

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to '/facility_ios', alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        format.html { redirect_to facility_ios_url }
        format.js { redirect_to facility_ios_url, :remote => true }
      end
    end
  end
end
