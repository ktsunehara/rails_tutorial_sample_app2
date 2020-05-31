class SessionsController < ApplicationController
  def new
    # form_withのscope: :session + url: login_pathを参照
  end
  # post / login
  def create
    # scope: :session =params[:session][:email]でログインフォームの情報が取れる
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in (user)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = 'ダメですよ'
        message += 'メールのリンクをクリックしてね。'
        flash[:danger] = 'message'
        redirect_to root_url
      end
    else
        flash.now[:danger] = 'Invalid email/password combination' 
        # renderなので、.nowが必要。遷移なし扱いのため。
        render 'new'
    end
  end
  
  def destroy
      log_out if logged_in?
      redirect_to root_url
  end 
end
