class SessionsController < ApplicationController

  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      #認証エラー
      flash.now[:danger] = "Invalid email/password combination"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end
end
