# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
=begin

  before_filter :set_i18n_locale_from_params
  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice]=
            "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
  def default_url_options
    { :locale => I18n.locale }
  end
=end

  before_filter :authorize
  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => '您尚未登录，请先登录系统'
    end
  end

  def ensure_sys_admin
    unless User.verify_is_sys_admin_by_id(session[:user_id])
      redirect_to login_url, :notice => '请以系统管理员身份登录'
    end
  end

  def ensure_school_admin
    unless User.verify_is_school_admin_by_id(session[:user_id])
      redirect_to login_url, :notice => '请以学校领导身份登录'
    end
  end

  def ensure_store_admin
    unless User.verify_is_store_admin_by_id(session[:user_id])
      redirect_to login_url, :notice => '请以实训管理员身份登录'
    end
  end

  def ensure_teacher
    unless User.verify_is_teacher_by_id(session[:user_id])
      redirect_to login_url, :notice => '请以教师身份登录'
    end
  end

  def ensure_school_or_store_admin
    unless User.verify_is_school_admin_by_id(session[:user_id]) || User.verify_is_store_admin_by_id(session[:user_id])
      redirect_to login_url, :notice => '请以学校领导或实训管理员身份登录'
    end
  end
end
