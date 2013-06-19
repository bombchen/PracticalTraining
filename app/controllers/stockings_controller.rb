# encoding: utf-8
class StockingsController < ApplicationController

  append_before_filter :ensure_school_or_store_admin

  # GET /stockings
  # GET /stockings.json
  def index
    @stockings = Stocking.all(:order => 'id desc').paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /stockings/1
  # GET /stockings/1.json
  def show
    @stocking = Stocking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /stockings/new
  # GET /stockings/new.json
  def new
    @stocking = Stocking.new
    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to stockings_url, alert: '存在未完成的盘点，无法开始新的盘点' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        format.html
        format.js
      end
    end
  end

  # GET /stockings/1/edit
  def edit
    @stocking = Stocking.find(params[:id])
    if @stocking.finished?
      render :js => %(show_warning('非法操作', '资产盘点已结束，无法修改'))
      return
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /stockings
  # POST /stockings.json
  def create
    @stocking = Stocking.new(params[:stocking])
    @stocking.owner_id = session[:user_id]

    respond_to do |format|
      if Stocking.any_not_finished?
        format.html { redirect_to stockings_url, alert: '存在未完成的盘点，无法开始新的盘点' }
        format.js { render :js => %(show_warning('非法操作', '正在进行资产盘点，无法执行该操作，请联系管理员')) }
      else
        if @stocking.save
          format.html { redirect_to edit_stocking_path(@stocking), notice: '资产盘点已启动' }
          format.js { redirect_to edit_stocking_path(@stocking), :remote => true }
        else
          format.html { render action: 'new' }
          format.js { render action: 'new' }
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
        format.js { render :js => %(show_notice('保存成功')) }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
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
      format.js { redirect_to stockings_url, :remote => true }
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
        format.js { redirect_to @stocking, :remote => true }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end
end
