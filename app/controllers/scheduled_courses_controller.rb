# encoding: utf-8
class ScheduledCoursesController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /scheduled_courses
  # GET /scheduled_courses.json
  def index
    @scheduled_courses = ScheduledCourse.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /scheduled_courses/1
  # GET /scheduled_courses/1.json
  def show
    @scheduled_course = ScheduledCourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /scheduled_courses/new
  # GET /scheduled_courses/new.json
  def new
    @scheduled_course = ScheduledCourse.new
    @fields = Array.new
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /scheduled_courses/1/edit
  def edit
    @scheduled_course = ScheduledCourse.find(params[:id])
    @fields = Field.get_available_fields_by_schedule(@scheduled_course.wday,
                                                     @scheduled_course.idx,
                                                     @scheduled_course.begin_date,
                                                     @scheduled_course.end_date)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /scheduled_courses
  # POST /scheduled_courses.json
  def create
    @scheduled_course = ScheduledCourse.new(params[:scheduled_course])

    respond_to do |format|
      if @scheduled_course.save
        format.html { redirect_to @scheduled_course, notice: '新建计划课程成功' }
        format.js { redirect_to @scheduled_course, :remote => true }
      else
        @fields = Field.get_available_fields_by_schedule(@scheduled_course.wday,
                                                         @scheduled_course.idx,
                                                         @scheduled_course.begin_date,
                                                         @scheduled_course.end_date)
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /scheduled_courses/1
  # PUT /scheduled_courses/1.json
  def update
    @scheduled_course = ScheduledCourse.find(params[:id])

    respond_to do |format|
      if @scheduled_course.update_attributes(params[:scheduled_course])
        format.html { redirect_to @scheduled_course, notice: '计划课程更新成功' }
        format.js { redirect_to @scheduled_course, :remote => true }
      else
        @fields = Field.get_available_fields_by_schedule(@scheduled_course.wday,
                                                         @scheduled_course.idx,
                                                         @scheduled_course.begin_date,
                                                         @scheduled_course.end_date)
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /scheduled_courses/1
  # DELETE /scheduled_courses/1.json
  def destroy
    @scheduled_course = ScheduledCourse.find(params[:id])
    @scheduled_course.destroy

    respond_to do |format|
      format.html { redirect_to scheduled_courses_url }
      format.js { redirect_to scheduled_courses_url, :remote => true }
    end
  end

  def get_available_fields
    if !params[:wday].nil?
      @filter_wday = params[:wday]
    end
    if !params[:idx].nil?
      @filter_idx = params[:idx]
    end
    if !params[:bd].nil?
      @filter_begin_date = params[:bd]
    end
    if !params[:ed].nil?
      @filter_end_date = params[:ed]
    end
    @fields = Field.get_available_fields_by_schedule(@filter_wday, @filter_idx, @filter_begin_date, @filter_end_date)
    render json: @fields.map { |f| [f.id, f.name] }
  end
end
