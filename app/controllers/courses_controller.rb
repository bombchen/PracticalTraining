# encoding: utf-8
class CoursesController < ApplicationController

  append_before_filter :ensure_teacher

  # GET /courses
  # GET /courses.json
  def index
    @week_offset = params[:week].nil? ? 0 : Integer(params[:week])
    @begin_date = Date.today+@week_offset*7-Date.today.wday
    @end_date = Date.today+@week_offset*7-Date.today.wday+6
    query = 'SELECT c.* FROM courses c ' +
        'WHERE c.date BETWEEN "'+ @begin_date.to_s+'" AND "'+@end_date.to_s+'" ' +
        'AND c.teacher_id = ' + session[:user_id].to_s
    @courses = Course.find_by_sql(query)
    @courses_hash = Hash.new
    @courses.each do |course|
      @courses_hash[course.date.wday*100+course.idx] = course
    end
    @schedule_hash = Hash.new
    query = 'SELECT sc.* FROM scheduled_courses sc ' +
        'WHERE sc.begin_date <= "' + @end_date.to_s + '" ' +
        'AND sc.end_date >= "' + @begin_date.to_s + '" ' +
        'AND sc.teacher_id = ' + session[:user_id].to_s
    @tmp = ScheduledCourse.find_by_sql(query)
    @tmp.each do |s|
      dt = @begin_date + s.wday
      if s.begin_date <= dt && s.end_date >= dt
        @schedule_hash[s.wday*100+s.idx] = s
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
    @course.date = Date.today
    @course.idx = 1
    if !params[:dt].nil?
      @course.date = params[:dt]
    end
    if !params[:idx].nil?
      @course.idx = params[:idx]
    end

    @filter_date = @course.date
    @filter_idx = @course.idx

    @fields = Field.get_available_fields(@filter_date.to_s, @filter_idx, @course.id)

    if !params[:sch].nil?
      @schedule = ScheduledCourse.find(params[:sch])
      @course.cls = @schedule.cls
      @course.idx = @schedule.idx
      @course.field_id = @schedule.field_id
      @course.teacher_id = @schedule.teacher_id
      @course.title = @schedule.title
      if @schedule.scheduled_facilities.any?
        @schedule.scheduled_facilities.each do |app|
          @course.facility_applications << FacilityApplication.new(:facility_id => app.facility_id, :applied => 0)
        end
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    if @course.course_review.status == 1
      render :js => %(show_warning('编辑课程失败', '课程已审核通过，无法更改'))
      return
    end
    @filter_date = @course.date
    @filter_idx = @course.idx
    @fields = Field.get_available_fields(@filter_date, @filter_idx, @course.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    @course.teacher_id = session[:user_id]

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: '课程申请已成功提交' }
        format.js { redirect_to @course, :remote => true }
      else
        @fields = Field.get_available_fields(@course.date, @course.idx, @course.id)
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])
    if @course.course_review.status == 1
      render :js => %(show_warning('编辑课程失败', '课程已审核通过，无法更改'))
      return
    end
    if @course.course_review.status == -1
      @course.course_review.status = 0
    end
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: '课程申请已更新' }
        format.js { redirect_to @course, :remote => true }
      else
        @fields = Field.get_available_fields(@course.date, @course.idx, @course.id)
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    if @course.course_review.status == 1
      render :js => %(show_warning('编辑课程失败', '课程已审核通过，无法删除'))
      return
    end
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_path }
      format.js { redirect_to courses_path, :remote => true }
    end
  end

  def confirm_schedule
    @course = Course.new(params[:course])
    @schedule = ScheduledCourse.find(params[:schedule_id])
    @course.cls = @schedule.cls
    @course.idx = @schedule.idx
    @course.field_id = @schedule.field_id
    @course.teacher_id = @schedule.teacher_id
    @course.title = @schedule.title
    @course.facility_applications.build
    @schedule.scheduled_facilities.each do |app|
      @course.facility_applications << FacilityApplication.new(:facility_id => app.facility_id, :applied => 0)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def get_available_fields
    if !params[:date].nil?
      @filter_date = params[:date]
    end
    if !params[:idx].nil?
      @filter_idx = params[:idx]
    end
    @fields = Field.get_available_fields(@filter_date, @filter_idx, params[:cid])
    render json: @fields.map { |f| [f.id, f.name] }
  end
end
