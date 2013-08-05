# encoding: utf-8
class UsersController < ApplicationController

  append_before_filter :ensure_sys_admin

  # GET /users
  # GET /users.json
  def index
    @filter_acct = params[:acct].nil? ? '' : params[:acct].strip
    @filter_usn = params[:usn].nil? ? '' : params[:usn].strip
    @filter_role = params[:role].nil? ? 'all' : params[:role].strip

    @users = User.filter(@filter_acct, @filter_usn, @filter_role).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @user.user_role_mappings.each do |urm|
      if urm.role.name == 'sysadmin'
        render :js => %(show_warning('非法操作', '无法修改系统管理员'))
        return
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.account = @user.account.strip
    @user.name = @user.name.strip
    respond_to do |format|
      if @user.validate_and_save!
        format.html { redirect_to @user, notice: '用户已创建' }
        format.js { redirect_to @user, :remote => true }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @user.account = @user.account.strip
    @user.name = @user.name.strip
    respond_to do |format|
      if @user.validate_and_update(params[:user])
        format.html { redirect_to @user, notice: '用户已更新' }
        format.js { redirect_to @user, :remote => true }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.user_role_mappings.each do |urm|
      if urm.role.name == 'sysadmin'
        render :js => %(show_warning('非法操作', '无法删除系统管理员'))
        return
      end
    end
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url }
        format.js { redirect_to users_url, :remote => true }
      end
    else
      render :js => %(show_warning('删除账号失败', '#{@user.errors.full_messages.join(', ')}'))
    end
  end

  def reset_password
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
