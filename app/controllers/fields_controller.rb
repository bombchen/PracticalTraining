# encoding: utf-8
class FieldsController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /fields
  # GET /fields.json
  def index
    @fields = Field.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /fields/1
  # GET /fields/1.json
  def show
    @field = Field.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /fields/new
  # GET /fields/new.json
  def new
    @field = Field.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /fields/1/edit
  def edit
    @field = Field.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /fields
  # POST /fields.json
  def create
    @field = Field.new(params[:field])
    @field.name = @field.name.strip
    respond_to do |format|
      if @field.save
        format.html { redirect_to @field, notice: '场地添加成功' }
        format.js { redirect_to @field, :remote => true }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /fields/1
  # PUT /fields/1.json
  def update
    @field = Field.find(params[:id])
    @field.name = @field.name.strip
    respond_to do |format|
      if @field.update_attributes(params[:field])
        format.html { redirect_to @field, notice: '场地更新成功' }
        format.js { redirect_to @field, :remote => true }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /fields/1
  # DELETE /fields/1.json
  def destroy
    @field = Field.find(params[:id])
    @field.destroy

    respond_to do |format|
      format.html { redirect_to fields_url }
      format.js { redirect_to fields_url, :remote => true }
    end
  end
end
