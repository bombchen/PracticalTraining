# encoding: utf-8
class DepartmentsController < ApplicationController

  append_before_filter :ensure_store_admin

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /departments/new
  # GET /departments/new.json
  def new
    @department = Department.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /departments/1/edit
  def edit
    @department = Department.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(params[:department])

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: '新部门已创建' }
        format.js { redirect_to @department, :remote => true }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /departments/1
  # PUT /departments/1.json
  def update
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.update_attributes(params[:department])
        format.html { redirect_to @department, notice: '部门信息已更新' }
        format.js { render action: 'show' }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department = Department.find(params[:id])
    respond_to do |format|
      if  @department.destroy
        format.html { redirect_to departments_url }
        format.js { redirect_to departments_path, :remote => true }
      else
        format.html { redirect_to @department, alert: '删除 '+@department.name+' 失败' }
        format.js { render :js => %(show_warning('删除 #{@department.name} 失败', '#{@department.error_message}')) }
      end

    end
  end
end
