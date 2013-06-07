class RecordReviewsController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /record_reviews
  # GET /record_reviews.json
  def index
    @record_reviews = RecordReview.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @record_reviews }
    end
  end

  # GET /record_reviews/1
  # GET /record_reviews/1.json
  def show
    @record_review = RecordReview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record_review }
    end
  end

  # GET /record_reviews/new
  # GET /record_reviews/new.json
  def new
    @record_review = RecordReview.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record_review }
    end
  end

  # GET /record_reviews/1/edit
  def edit
    @record_review = RecordReview.find(params[:id])
    @practice_record = @record_review.practice_record
    @course = @practice_record.course
  end

  # POST /record_reviews
  # POST /record_reviews.json
  def create
    @record_review = RecordReview.new(params[:record_review])

    respond_to do |format|
      if @record_review.save
        format.html { redirect_to @record_review, notice: 'Record review was successfully created.' }
        format.json { render json: @record_review, status: :created, location: @record_review }
      else
        format.html { render action: "new" }
        format.json { render json: @record_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /record_reviews/1
  # PUT /record_reviews/1.json
  def update
    @record_review = RecordReview.find(params[:id])

    respond_to do |format|
      if @record_review.update_attributes(params[:record_review])
        format.html { redirect_to @record_review, notice: '实训记录审核已更新' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /record_reviews/1
  # DELETE /record_reviews/1.json
  def destroy
    @record_review = RecordReview.find(params[:id])
    @record_review.destroy

    respond_to do |format|
      format.html { redirect_to record_reviews_url }
      format.json { head :no_content }
    end
  end
end
