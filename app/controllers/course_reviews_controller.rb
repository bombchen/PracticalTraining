# encoding: utf-8
class CourseReviewsController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /course_reviews
  # GET /course_reviews.json
  def index
    bdt = params[:bdt]
    edt = params[:edt]
    cdt = params[:cdt]
    @begin_date = (bdt.nil? ? Date.today : bdt)
    @end_date = (edt.nil? ? @begin_date + 7 : edt)
    @status = (cdt.nil? ? '全部' : cdt)

    @course_reviews = CourseReview.filter(@begin_date.to_date.to_s, @end_date.to_date.to_s, @status).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /course_reviews/1
  # GET /course_reviews/1.json
  def show
    @course_review = CourseReview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /course_reviews/new
  # GET /course_reviews/new.json
  def new
    @course_review = CourseReview.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /course_reviews/1/edit
  def edit
    @course_review = CourseReview.find(params[:id])
    @course = @course_review.course

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /course_reviews
  # POST /course_reviews.json
  def create
    @course_review = CourseReview.new(params[:course_review])

    respond_to do |format|
      if @course_review.save
        format.html { redirect_to @course_review, notice: 'Course review was successfully created.' }
        format.js
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /course_reviews/1
  # PUT /course_reviews/1.json
  def update
    @course_review = CourseReview.find(params[:id])

    respond_to do |format|
      if @course_review.update_attributes(params[:course_review])
        format.html { redirect_to @course_review, notice: '课程审核已更新' }
        format.js {render action: 'show'}
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /course_reviews/1
  # DELETE /course_reviews/1.json
  def destroy
    @course_review = CourseReview.find(params[:id])
    @course_review.destroy

    respond_to do |format|
      format.html { redirect_to course_reviews_url }
      format.js
    end
  end
end
