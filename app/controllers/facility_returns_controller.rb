# encoding: utf-8
class FacilityReturnsController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /facility_returns
  # GET /facility_returns.json
  def index
    @begin_date = Date.today
    @end_date = Date.today
    @courses = Course.all #(:conditions => ['date >= ? AND date <= ?',  @begin_date, @end_date])
    @facility_returns = FacilityReturn.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facility_returns }
    end
  end

  # GET /facility_returns/1
  # GET /facility_returns/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /facility_returns/new
  # GET /facility_returns/new.json
  def new
    @facility_return = FacilityReturn.new

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.json { head :no_content }
      else
        format.html # new.html.erb
        format.json { render json: @facility_return }
      end
    end
  end

  # GET /facility_returns/1/edit
  def edit
    @course = Course.find(params[:id])
    @facility_applications = @course.facility_applications
    if Stocking.any_not_finished?
      redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员'
      return
    end
  end

# POST /facility_returns
# POST /facility_returns.json
  def create
    @facility_return = FacilityReturn.new(params[:facility_return])

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.json { head :no_content }
      else
        if @facility_return.save
          format.html { redirect_to @facility_return, notice: '新建成功' }
          format.json { render json: @facility_return, status: :created, location: @facility_return }
        else
          format.html { render action: 'new' }
          format.json { render json: @facility_return.errors, status: :unprocessable_entity }
        end
      end
    end
  end

# PUT /facility_returns/1
# PUT /facility_returns/1.json
  def update
    @facility_return = FacilityReturn.find(params[:id])

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.json { head :no_content }
      else
        if @facility_return.update_with_sync_up(params[:facility_return])
          format.html { redirect_to edit_facility_return_path(@facility_return.facility_application.course) }
          format.json { head :no_content }
        else
          format.html { redirect_to edit_facility_return_path(@facility_return.facility_application.course), alert: '更新失败' }
          format.json { render json: @facility_return.errors, status: :unprocessable_entity }
        end
      end
    end
  end

# DELETE /facility_returns/1
# DELETE /facility_returns/1.json
  def destroy
    if Stocking.any_not_finished?
      redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员'
      return
    end
    @facility_return = FacilityReturn.find(params[:id])
    @facility_return.destroy

    respond_to do |format|
      format.html { redirect_to facility_returns_url }
      format.json { head :no_content }
    end
  end

  def borrow_process
    if Stocking.any_not_finished?
      redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员'
      return
    end
    @facility_return = FacilityReturn.find(params[:id])
    if @facility_return.status != 0
      redirect_to edit_facility_return_path(@facility_return), alert: '请勿重复领用'
      return
    end
    @facility_return.status = 1
    @facility_return.borrowed_time = Time.now
    respond_to do |format|
      format.js
      format.html
    end
  end

  def return_process
    if Stocking.any_not_finished?
      redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员'
      return
    end
    @facility_return = FacilityReturn.find(params[:id])

    @facility_return.status = 2
    @facility_return.returned_time = Time.now
    respond_to do |format|
      format.js
      format.html # return_process.html.erb
    end
  end

end
