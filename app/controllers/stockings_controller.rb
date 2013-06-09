# encoding: utf-8
class StockingsController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  # GET /stockings
  # GET /stockings.json
  def index
    @stockings = Stocking.all(:order => 'id desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stockings }
    end
  end

  # GET /stockings/1
  # GET /stockings/1.json
  def show
    @stocking = Stocking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stocking }
    end
  end

  # GET /stockings/new
  # GET /stockings/new.json
  def new
    @stocking = Stocking.new

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to stockings_url, alert: '存在未完成的盘点，无法开始新的盘点' }
        format.json { head :no_content }
      else
        format.html
        format.json { render json: @stocking }
      end
    end
  end

  # GET /stockings/1/edit
  def edit
    @stocking = Stocking.find(params[:id])
    if @stocking.finished?
      redirect_to @stocking, alert: '资产盘点已结束，无法修改'
    end
  end

  # POST /stockings
  # POST /stockings.json
  def create
    @stocking = Stocking.new(params[:stocking])

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to stockings_url, alert: '存在未完成的盘点，无法开始新的盘点' }
        format.json { head :no_content }
      else
        if @stocking.save
          format.html { redirect_to edit_stocking_path(@stocking), notice: '资产盘点已启动' }
          format.json { render json: @stocking, status: :created, location: @stocking }
        else
          format.html { render action: 'new' }
          format.json { render json: @stocking.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /stockings/1
  # PUT /stockings/1.json
  def update
    @stocking = Stocking.find(params[:id])

    respond_to do |format|
      if @stocking.update_attributes(params[:stocking])
        format.html { redirect_to edit_stocking_path(@stocking), notice: '保存成功' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stocking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stockings/1
  # DELETE /stockings/1.json
  def destroy
    @stocking = Stocking.find(params[:id])
    @stocking.destroy

    respond_to do |format|
      format.html { redirect_to stockings_url }
      format.json { head :no_content }
    end
  end

  def end_stocking
    @stocking = Stocking.find(params[:id])
    if !@stocking.update_attributes(params[:stocking])
      render action: 'edit'
      return
    end
    respond_to do |format|
      if @stocking.end_stocking!
        format.html { redirect_to @stocking, notice: '资产盘点结束，系统功能重新开放' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stocking.errors, status: :unprocessable_entity }
      end
    end
  end
end
