# encoding: utf-8
class PracticeRecordsController < ApplicationController

  append_before_filter :ensure_teacher

  # GET /practice_records
  # GET /practice_records.json
  def index
    @practice_records = (PracticeRecord.all.take_while { |r| r.course.teacher_id == session[:user_id] }).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /practice_records/1
  # GET /practice_records/1.json
  def show
    @practice_record = PracticeRecord.find(params[:id])
    @course = @practice_record.course

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /practice_records/new
  # GET /practice_records/new.json
  def new
    @practice_record = PracticeRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /practice_records/1/edit
  def edit
    @practice_record = PracticeRecord.find(params[:id])
    @course = @practice_record.course
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /practice_records
  # POST /practice_records.json
  def create
    @practice_record = PracticeRecord.new(params[:practice_record])

    respond_to do |format|
      if @practice_record.save
        format.html { redirect_to @practice_record, notice: '实训记录已建立' }
        format.js { redirect_to @practice_record, :remote => true }
      else
        format.html {
          flash[:error] = @practice_record.errors.full_messages.to_sentence
          render action: 'new'
        }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /practice_records/1
  # PUT /practice_records/1.json
  def update
    @practice_record = PracticeRecord.find(params[:id])
    if !params[:practice_record]['record'].nil?
      @practice_record.record_review.status = 1
    end
    respond_to do |format|
      if @practice_record.update_attributes(params[:practice_record])
        format.html { redirect_to @practice_record, notice: '实训记录已更新' }
        format.js { redirect_to @practice_record, :remote => true }
      else
        format.html {
          flash[:error] = @practice_record.errors.full_messages.to_sentence
          render action: 'edit'
        }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /practice_records/1
  # DELETE /practice_records/1.json
  def destroy
    @practice_record = PracticeRecord.find(params[:id])
    @practice_record.destroy

    respond_to do |format|
      format.html { redirect_to practice_records_url }
      format.js { redirect_to practice_records_url, :remote => true }
    end
  end
end
