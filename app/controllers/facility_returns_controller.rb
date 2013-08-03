# encoding: utf-8
class FacilityReturnsController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /facility_returns
  # GET /facility_returns.json
  def index
    @date = (params[:dt].nil? ? Date.today : params[:dt])
    @status = (params[:sta].nil? ? 1 : params[:sta].to_i)
    query = 'SELECT c.* FROM courses c ' +
        'JOIN course_reviews r ' +
        'ON c.id = r.course_id ' +
        'WHERE c.date = "' + @date.to_s + '" '
    if @status != -2
      query += 'AND r.status = ' + @status.to_s
    end
    @courses = (Course.find_by_sql(query)).paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /facility_returns/1
  # GET /facility_returns/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /facility_returns/new
  # GET /facility_returns/new.json
  def new
    @facility_return = FacilityReturn.new

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        format.html # new.html.erb
        format.js
      end
    end
  end

  # GET /facility_returns/1/edit
  def edit
    @course = Course.find(params[:id])
    @facility_applications = @course.facility_applications
    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        format.html
        format.js
      end
    end
  end

# POST /facility_returns
# POST /facility_returns.json
  def create
    @facility_return = FacilityReturn.new(params[:facility_return])

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to facility_returns_url, alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        if @facility_return.save
          format.html { redirect_to @facility_return, notice: '新建成功' }
          format.js { redirect_to @facility_return, :remote => true }
        else
          format.html { render action: 'new' }
          format.js { render action: 'new' }
        end
      end
    end
  end

# PUT /facility_returns/1
# PUT /facility_returns/1.json
  def update
    @facility_return = FacilityReturn.find(params[:id])

    if Stocking.any_not_finished?
      render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员'))
      return
    end
    respond_to do |format|
      if @facility_return.update_with_sync_up(params[:facility_return])
        format.html { redirect_to edit_facility_return_path(@facility_return.facility_application.course) }
        format.js { redirect_to edit_facility_return_path(@facility_return.facility_application.course), :remote => true }
      else
        err_summary ||= ''
        err_summary += @facility_return.error_message
        @facility_return.errors.full_messages.each do |msg|
          err_summary += msg
        end
        format.html { redirect_to edit_facility_return_path(@facility_return.facility_application.course), alert: @facility_return.error_message }
        format.js { render :js => %(show_warning('更新失败', '#{err_summary}')) }
      end
    end
  end

# DELETE /facility_returns/1
# DELETE /facility_returns/1.json
  def destroy
    @facility_return = FacilityReturn.find(params[:id])

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to '/facility_ios', alert: '正在进行资产盘点，无法执行该操作，请联系管理员' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      elsif @facility_return.destroy
        format.html { redirect_to facility_returns_url }
        format.js { redirect_to facility_returns_url, :remote => true }
      else
        format.html { redirect_to facility_returns_url, alert: @facility_return.error_message }
        format.js { render :js => %(show_warning('删除失败', '#{@facility_return.error_message}')) }
      end
    end
  end

  def outstanding
    @courses = (Course.find_by_sql ('SELECT DISTINCT c.* FROM courses c ' +
        'JOIN facility_applications fa ON c.id = fa.course_id ' +
        'JOIN facility_returns fr ON fa.id = fr.application_id '+
        'JOIN facilities f ON f.id = fa.facility_id '+
        'WHERE f.facility_type <> 2 ' +
        'AND fr.status = 1')).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def borrow_process
    @facility_return = FacilityReturn.find(params[:id])
    if Stocking.any_not_finished?
      render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员'))
      return
    end
    if @facility_return.status != 0
      render :js => %(show_warning('领用失败', '请勿重复领用'))
      return
    end
    @facility_return.status = 1
    @facility_return.borrowed_time = Time.now
    respond_to do |format|
      format.html
      format.js
    end
  end

  def return_process
    @facility_return = FacilityReturn.find(params[:id])
    if Stocking.any_not_finished?
      render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员'))
      return
    end
    if @facility_return.status == 0
      render :js => %(show_warning('归还失败', '请先领用再归还'))
      return
    end
    if @facility_return.status == 2
      render :js => %(show_warning('归还失败', '请勿重复归还'))
      return
    end
    if @facility_return.status != 1
      render :js => %(show_warning('归还失败', '未知状态无法归还'))
      return
    end

    @facility_return.status = 2
    @facility_return.returned_time = Time.now
    respond_to do |format|
      format.html
      format.js
    end
  end

end
