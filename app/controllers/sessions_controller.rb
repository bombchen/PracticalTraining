class SessionsController < ApplicationController

  skip_before_filter :authorize

  def new
  end

  def create
    if user = User.authenticate(params[:account], params[:password])
      session[:user_id] = user.id
      redirect_to index_url
    else
      redirect_to login_url, :alert => '用户名或密码不正确'
    end
  end

  def destroy
    @sid = session[:user_id]
    session[:user_id] = nil
    redirect_to index_url, :notice => '已退出系统'
  end
end
