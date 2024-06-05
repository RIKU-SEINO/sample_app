module SessionsHelper

    # 渡されたユーザーでログインする
    def log_in(user)
      session[:user_id] = user.id
      session[:session_token] = user.session_token
    end

    def remember(user)
      user.remember #ユーザーモデルで定義した
      cookies.permanent.encrypted[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end
  
    # 現在ログイン中のユーザーを返す（いる場合）
    def current_user
      if (user_id = session[:user_id])
        user = User.find_by(id: User.find_by(id: user_id))
        if user && session[:session_token] == user.session_token
          @current_user = user
        end
      elsif (user_id = cookies[:user_id])
        user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
    end
  
    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
      !current_user.nil?
    end

    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    def log_out
      forget(current_user)
      reset_session
      @current_user = nil
    end
  end
  
