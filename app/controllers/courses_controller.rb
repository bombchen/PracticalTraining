class CoursesController < ApplicationController

  append_before_filter :ensure_teacher

  # GET /courses
  # GET /courses.json
  def index
    @week_offset = params[:week].nil? ? 0 : Integer(params[:week])
    @begin_date = Date.today+@week_offset*7-Date.today.wday
    @end_date = Date.today+@week_offset*7-Date.today.wday+6
    @courses = Course.find_all_by_date(@begin_date..@end_date).take_while { |c| c.teacher_id == session[:user_id] }
    @courses_hash = Hash.new
    @courses.each do |course|
      @courses_hash[course.date.wday*100+course.idx] = course
    end
    @schedule_hash = Hash.new
    @tmp = ScheduledCourse.where('begin_date <= ? AND end_date >= ?', @end_date, @begin_date)
    @tmp.each do |s|
      dt = @begin_date + s.wday
      if s.begin_date <= dt && s.end_date >= dt
        @schedule_hash[s.wday*100+s.idx] = s
      end
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
    if !params[:dt].nil?
      @course.date = params[:dt]
    end
    @course.idx = 1

    @filter_date = @course.date
    @filter_idx = @course.idx

    @fields = Field.get_available_fields(@filter_date.to_s, @filter_idx)

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
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    @filter_date = @course.date
    @filter_idx = @course.idx
    @fields = Field.get_available_fields(@filter_date, @filter_idx)
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    @course.teacher_id = session[:user_id]

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: '课程申请已成功提交' }
        format.json { render json: @course, status: :created, location: @course }
      else
        @fields = Field.get_available_fields(@course.date, @course.idx)
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: '课程申请已更新' }
        format.json { head :no_content }
      else
        @fields = Field.get_available_fields(@course.date, @course.idx)
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
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
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  def get_available_fields
    if !params[:date].nil?
      @filter_date = params[:date]
    end
    if !params[:idx].nil?
      @filter_idx = params[:idx]
    end
    @fields = Field.get_available_fields(@filter_date, @filter_idx)
    render json: @fields.map { |f| [f.id, f.name] }
  end
end
