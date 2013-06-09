# encoding: utf-8
class UserRoleMappingsController < ApplicationController

  append_before_filter :ensure_sys_admin

  # GET /user_role_mappings
  # GET /user_role_mappings.json
  def index
    @user_role_mappings = UserRoleMapping.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_role_mappings }
    end
  end

  # GET /user_role_mappings/1
  # GET /user_role_mappings/1.json
  def show
    @user_role_mapping = UserRoleMapping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_role_mapping }
    end
  end

  # GET /user_role_mappings/new
  # GET /user_role_mappings/new.json
  def new
    @user_role_mapping = UserRoleMapping.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_role_mapping }
    end
  end

  # GET /user_role_mappings/1/edit
  def edit
    @user_role_mapping = UserRoleMapping.find(params[:id])
  end

  # POST /user_role_mappings
  # POST /user_role_mappings.json
  def create
    @user_role_mapping = UserRoleMapping.new(params[:user_role_mapping])

    respond_to do |format|
      if @user_role_mapping.save
        format.html { redirect_to @user_role_mapping, notice: 'User role mapping was successfully created.' }
        format.json { render json: @user_role_mapping, status: :created, location: @user_role_mapping }
      else
        format.html { render action: "new" }
        format.json { render json: @user_role_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_role_mappings/1
  # PUT /user_role_mappings/1.json
  def update
    @user_role_mapping = UserRoleMapping.find(params[:id])

    respond_to do |format|
      if @user_role_mapping.update_attributes(params[:user_role_mapping])
        format.html { redirect_to @user_role_mapping, notice: 'User role mapping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_role_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_role_mappings/1
  # DELETE /user_role_mappings/1.json
  def destroy
    @user_role_mapping = UserRoleMapping.find(params[:id])
    @user_role_mapping.destroy

    respond_to do |format|
      format.html { redirect_to user_role_mappings_url }
      format.json { head :no_content }
    end
  end
end
