class SessionsController < ApplicationController
  def new
    # form_withのscope: :session + url: login_pathを参照
  end
  # post / login
  def create
    # scope: :session =params[:session][:email]でログインフォームの情報が取れる
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in (user)
      flash[:success] = 'ログイン成功' 
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination' 
      # renderなので、.nowが必要。遷移なし扱いのため。
      render 'new'
    end
  end
  
  def destroy
      log_out
      redirect_to root_url
    end 
end
